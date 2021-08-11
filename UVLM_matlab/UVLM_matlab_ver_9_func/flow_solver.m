function ini = flow_solver(par,ini,nt)

ini.heave(nt) = ini.amp_heave*sin(ini.freq_heave*(nt-1)*par.dt) + ini.h(nt);
ini.heave_vel(nt) = ini.freq_heave*ini.amp_heave*cos(ini.freq_heave*(nt-1)*par.dt) + ini.h_dot(nt);
ini.pitch(nt) = ini.amp_pitch*sin(ini.freq_pitch*(nt-1)*par.dt) + ini.alp(nt);
ini.pitch_vel(nt) = ini.freq_pitch*ini.amp_pitch*cos(ini.freq_pitch*(nt-1)*par.dt) + ini.alp_dot(nt);

if nt==1
    lwt = par.u_step(nt)*par.dt;
    owt = 0;                
    tau_nt1 = 0;
    phi_nt1 = 0;
    
    chord_20 = false(par.tot_time_step,1);
    csv = 0;
    
    cn = 0; ct = 0;
    
    cwx = 0; cwy = 0;
    cft = 0;
else
    lwt = ini.lw(nt-1);
    owt = ini.ow(nt-1);
    tau_nt1 = ini.tau(nt-1);
    phi_nt1 = ini.phi(:,nt-1);
    
    chord_20 = ini.chord_20_cell{nt-1};
    csv = ini.csv(chord_20);
    
    ini.xsvt_ysvt(chord_20,:) = axistran('global_to_local',ini.xsv_ysv(chord_20,:),par.xpvt_ypvt,ini.heave(nt),ini.pitch(nt));  % axistran.f ... transformation of axis from global to local axis
    [cn,ct] = inf_coeff_due_to_core_vortex(par.xmaf_ymaf,ini.xsvt_ysvt(chord_20,:),par.theta_af);  % setcmnt.f (written outside iterct loop) ... calculates the normal & tangential influence coefficients on airfoil panel midpoints due to core vortices par.at any time step ... Cebeci pg 41, eqn 3.3.7 & 3.3.8
end

no_core_vort = sum(chord_20); % number of core vortices taken into consideration upto desired distance

xwb_ywb = [1 0]; % local coordinate of shed vortex panel attached to the trailing edge
xwe_ywe = xwb_ywb+lwt*[cos(owt) sin(owt)]; % local coordinate of shed vortex panel away from the trailing edge
xwm_ywm = 0.5*(xwb_ywb+xwe_ywe); % midpoint of shed vortex panel 
[vstn,vstt] = vstream(par.u_step(nt),par.xmaf_ymaf,ini.heave_vel(nt),ini.pitch(nt),ini.pitch_vel(nt),par.theta_af);  % vstream.f (written outside iterct loop) ... resolves the free stream velocity normal & tangential to each airfoil panel

%% iteration starts
tau_nt = tau_nt1;
for iterct = 1:par.itermax
    [~,~,bwn,bwt] = inf_coeff_due_to_panel('due_to_shed_vortex_panel',par.xmaf_ymaf,[xwb_ywb;xwe_ywe],par.theta_af,owt);  % setbwnt.f ... calculates the normal & tangential influence coefficients on airfoil panel midpoints due to shed vortex panel par.at all iterations of any time step ... similar to Cebeci pg 34, eqn 3.2.15
    
    [e,f] = solveabc(par.an,par.bn,bwn,par.perimeter,lwt,tau_nt1,vstn,cn,csv);  % seta.f, setb.f, setc.f, solveabc.f written together ... calculates inv(A)*b & inv(A)*c from Cebeci pg 43, eqn 3.3.13
    [p,q] = setvtpq(par.at,par.bt,bwt,par.perimeter,lwt,e,f,tau_nt1,vstt,ct,csv);  % setvtpq.f ... calculates the tauk dependent(p) & tauk independent(q) part of tangential velocity on each airfoil panel 

    tau_nt = solvtauk(p(1),q(1),p(end),q(end),par.perimeter,par.dt,tau_nt1,tau_nt);  % solvtauk.f ... solves the quadratic eqn for solution of tauk from Cebeci pg 39, eqn 3.3.6
    
    qs = e*tau_nt+f; % uniform source strength on each airfoil panel
    [awy,awx,bwy,bwx] = inf_coeff_due_to_panel('due_to_airfoil_panel',xwm_ywm,par.xaf_yaf,0,par.theta_af);  % stabwxy.f ... calculates the local x & y components of influence coeffients on shed vortex panel induced due to the airfoil panels
    
    if nt>1
        [cwy,cwx] = inf_coeff_due_to_core_vortex(xwm_ywm,ini.xsvt_ysvt(chord_20,:),0);  % stcwxy.f ... calculates the local x & y components of influence coeffients on shed vortex panel induced due to the core vortices
    end
    
    vstwx = par.u_step(nt)*cos(ini.pitch(nt))-ini.pitch_vel(nt)*xwm_ywm(:,2); % local x component of free stream velocity & tangential velocity due to pitching on shed vortex panel
    vstwy = par.u_step(nt)*sin(ini.pitch(nt))+ini.pitch_vel(nt)*(xwm_ywm(:,1)-par.xpvt_ypvt(1))+ini.heave_vel(nt); % local y component of free stream velocity, tangential velocity due to pitching & ini.heave velocity on shed vortex panel       
    
    [uw,vw] = setuvw(awx,awy,qs,bwx,bwy,tau_nt,vstwx,vstwy,cwx,cwy,csv);  % setuvw.f ... calculates the local x & y components of total induced velocity on the shed vortex panel
    
    lwt = sqrt(uw^2+vw^2)*par.dt; % the length of the shed vortex panel is updated in each iteration
    owt = atan(vw/uw); % the angle of inclination of shed vortex panel is updated in each iteration
    xwe_ywe = xwb_ywb+lwt*[cos(owt) sin(owt)]; % the local coordinate of shed vortex panel away from the trailing edge is updated in each iteration
    xwm_ywm = 0.5*(xwb_ywb+xwe_ywe); % the midpoint of shed vortex panel is updated in each iteration
end
%%
tauw = par.perimeter*(tau_nt1-tau_nt)/lwt;  % (written outside iterct loop) ... the vortex strength of shed vortex panel
vel = p*tau_nt+q;  % (written outside iterct loop) ... tangential velocity induced on each panel

ini.tau(nt) = tau_nt;
ini.lw(nt) = lwt;
ini.ow(nt) = owt;
ini.csv(nt) = (tau_nt1-tau_nt)*par.perimeter;

for index = par.ind:-1:1
    ini.phiairfoil(index) = ini.phiairfoil(index+1)-(vel(index)-vstt(index))*par.panlen(index); % calculates the potential par.at airfoil nodes wrt leading edge
end

for index = par.ind+2:par.npan+1
    ini.phiairfoil(index) = ini.phiairfoil(index-1)+(vel(index-1)-vstt(index-1))*par.panlen(index-1);
end

[~,xmidf_ymidf,panlenf] = frontpanels(par.fmax,par.npan,ini.pitch(nt),par.panlen);  % frontpanels.f ... calculates the midpoints and lengths of front panels wrt local axis
[~,aft,~,bft] = inf_coeff_due_to_panel('due_to_airfoil_panel',xmidf_ymidf,par.xaf_yaf,(pi+ini.pitch(nt))*ones(par.fmax-1,1),par.theta_af);  % fabcalc.f ... calculates the tangential influence coefficients on front panels due to airfoil panels
[~,~,~,bwft] = inf_coeff_due_to_panel('due_to_shed_vortex_panel',xmidf_ymidf,[xwb_ywb;xwe_ywe],(pi+ini.pitch(nt))*ones(par.fmax-1,1),owt);  % fabcalc.f ... calculates the tangential influence coefficients on front panels due to shed vortex panel

if nt>1
    [~,cft] = inf_coeff_due_to_core_vortex(xmidf_ymidf,ini.xsvt_ysvt(chord_20,:),(pi+ini.pitch(nt))*ones(par.fmax-1,1));  % fabcalc.f ... calculates the tangential influence coefficients on front panels due to core vortices
end

phile = calc_phile(aft,bft,bwft,qs,tau_nt,tauw,panlenf,cft,csv); % calculates the absolute potential par.at the leading edge assuming zero potential par.at infinity

phinode = phile+ini.phiairfoil; % calculates the absolute potential par.at the airfoil nodes
ini.phi(:,nt) = 0.5*(phinode(1:par.npan)+phinode(2:end)); % calculates the absolute potential par.at airfoil panel midpoints
cpr = (vstt.^2+vstn.^2-vel.^2-2*(ini.phi(:,nt)-phi_nt1)/par.dt)/(par.u_step(nt)^2); % calculates the pressure coefficients on each airfoil panel
CN = sum(-cpr.*par.panlen.*cos(par.theta_af),1); % calculates the local y components of pressure coefficients on each airfoil panel
CA = sum(-cpr.*par.panlen.*sin(par.theta_af),1); % calculates the local x components of pressure coefficients on each airfoil panel
CMOM = sum(cpr.*par.panlen.*sum(([cos(par.theta_af) sin(par.theta_af)].*(par.xmaf_ymaf-repmat(par.xpvt_ypvt,par.npan,1))),2)); % calculates the moment coefficient

ini.CL(nt) = CN*cos(ini.pitch(nt))-CA*sin(ini.pitch(nt)); % calculates the lift coefficient wrt global axis
ini.CD(nt) = CN*sin(ini.pitch(nt))+CA*cos(ini.pitch(nt)); % calculates the drag coefficient wrt global axis
ini.CM(nt) = CMOM; % calculates the moment coefficient wrt global axis

ini.L(nt) = 0.5*(par.rho_air)*(par.u_step(nt)^2)*(par.c)*(ini.CL(nt)); % calculates the lift generated in the present time step
ini.M(nt) = 0.5*(par.rho_air)*(par.u_step(nt)^2)*(par.c^2)*(ini.CM(nt)); % calculates the moment generated in the present time step

if nt>1
    [ahy,ahx,bhy,bhx] = inf_coeff_due_to_panel('due_to_airfoil_panel',ini.xsvt_ysvt(chord_20,:),par.xaf_yaf,zeros(no_core_vort,1),par.theta_af); % stabhxy.f ... calculates the local x & y components of influence coefficients on core vortices due to airfoil panels
    [~,~,bwhy,bwhx] = inf_coeff_due_to_panel('due_to_shed_vortex_panel',ini.xsvt_ysvt(chord_20,:),[xwb_ywb;xwe_ywe],zeros(no_core_vort,1),owt); % stbwhxy.f ... calculates the local x & y components of influence coefficients on core vortices due to shed vortex panel
    [chy,chx] = inf_coeff_due_to_core_vortex(ini.xsvt_ysvt(chord_20,:),ini.xsvt_ysvt(chord_20,:),zeros(no_core_vort,1)); % stchxy.f ... calculates the local x & y components of influence coefficients on core vortices due to other core vortices
    [uh,vh] = setuvh(ahx,ahy,qs,bhx,bhy,tau_nt,bwhx,bwhy,tauw,ini.pitch(nt),par.u_step(nt),chx,chy,csv); % setuvh.f ... calculates the total velocity induced in the local x & y direction due to the effect of airfoil panels, shed vortex panels & core vortices ... Cebeci, eqn 3.3.16 & 3.3.17
    ini.xsvt_ysvt(chord_20,:) = ini.xsvt_ysvt(chord_20,:)+[uh vh]*par.dt; % svloc.f ... calculates the updated coordinates of the core vortices
end
chord_20(nt) = true;
ini.xsvt_ysvt(nt,:) = xwm_ywm+[uw vw]*par.dt; % calculates the updated coordinates of the core vortex generated from the present time step shed vortex panel

xabs_yabs = axistran('local_to_global',par.xaf_yaf,par.xpvt_ypvt,ini.heave(nt),ini.pitch(nt)); % transforms the local coordinates of the airfoil panel to global coordinates
ini.xsv_ysv(chord_20,:) = axistran('local_to_global',ini.xsvt_ysvt(chord_20,:),par.xpvt_ypvt,ini.heave(nt),ini.pitch(nt)); % axvtton.m ... transforms the local coordinates of the core vortices to the global coordinates

chord_20 = (ini.xsv_ysv(chord_20,1) <= par.core_vort_upto*par.c); % logical array to find out the core vortices in the 21*c distance from the global origin ... change the first logic from 21*c to Inf to account for all the core vortices 
ini.chord_20_cell{nt} = chord_20;

ini.absolute_coord{nt} = [xabs_yabs; ini.xsv_ysv(chord_20,:)];