clear all; clc; close all;
n=150;
c=10;
b=c/2;
fr_str=100;
delta_t=0.001;
p=50000; %number of iterations

%%%%%%%%%%%%%%%%%%%%%%%%%%%
amp_pitch=0.17;
amp_heave=1;
freq_pitch=0; %rad/s
freq_heave=0; %rad/s
%%%%%%%%%%%%%%%%%%%%%%%%%%%


parameters=zeros(7,1);
parameters(1)=fr_str;
parameters(4)=delta_t;

[bound_vort_coord_rel,collac_rel]=plate_coord_calc(n,c);
influ_coeff=influ_coeff_calc(bound_vort_coord_rel,collac_rel);

circulation=zeros(n+5,1);
circ_coord=zeros(n+5,2);

wake_coord=[];
wake_vort=[];
temp_tangent_rel_vel_collac=zeros(n,1);
temp_v_w=zeros(n,1);
temp_bound_vort=zeros(n,1); %initial strength of the bound vortices
heave_disp=0;
heave_vel=-0;
x=[0;0];

delta_p=zeros(p,1);
D_in=zeros(p,1);
Lift=zeros(p,1);
i=1;
ind=(n:-1:1)';

for k=0:p
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (k*delta_t*fr_str>20*c)
        s=wake_coord(:,1)-circ_coord(n+1,1);
        index=find(s>20*c);
        wake_vort(index)=[];
        
        wake_coord(index,:)=[];
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    parameters(2)=amp_pitch*sin(freq_pitch*k*delta_t);
    parameters(3)=freq_pitch*(amp_pitch)*cos(freq_pitch*k*delta_t);
    parameters(5)=k;
    parameters(6)=amp_heave*sin(freq_heave*k*delta_t)+heave_disp;
    parameters(7)=freq_heave*amp_heave*cos(freq_heave*k*delta_t)+heave_vel;
    %x=[heave_disp/D;heave_vel/D]; %initial condtion for ode45
    [bound_vort_coord_abs,collac_abs]=bound_vort_coord_calc(bound_vort_coord_rel,collac_rel,parameters); %to calculate the absolute coordinates of bound vortices and collocation points
    [rhs,tangent_rel_vel_collac,v_w]=rhs_calc(circulation,circ_coord,collac_abs,collac_rel,parameters);
    bound_vorticity=bound_vort_calc(influ_coeff,rhs);
    
    wake_vort=[bound_vorticity(n+1);wake_vort]; %adding the just shed vortex to the already present wake vortices
    bound_vorticity(n+1)=[];
    circulation=[bound_vorticity;wake_vort];
    bound_vort=bound_vorticity;
    wake_coord=[bound_vort_coord_abs(n+1,:);wake_coord];
    %if (k<2000)
    %[wake_coord]=wake_coord_calc(circulation,bound_vort_coord_abs(1:n,:),wake_coord,delta_t);
    %end
    
   % if(k>=2000)
        [wake_coord]=wake_coord_calc_spec(circulation,bound_vort_coord_abs(1:n,:),wake_coord,delta_t);
    %end
    
    circ_coord=[bound_vort_coord_abs(1:n,:);wake_coord];
    delta_p(i,1)=1.225*(sum(temp_tangent_rel_vel_collac.*temp_bound_vort.*n./c)+sum((bound_vort-temp_bound_vort).*ind./delta_t));
    D_in(i,1)=1.2*sum(temp_v_w.*temp_bound_vort);
    temp_tangent_rel_vel_collac=tangent_rel_vel_collac;
temp_v_w=v_w;
temp_bound_vort=bound_vort;
Lift(i,1)=delta_p(i,1)*c/n;
temp_lift=Lift(i,1);
h_d(i,1)=heave_disp;
h_v(i,1)=heave_vel;
temp_circ_coord=circ_coord;
temp_circ_coord(:,1)=temp_circ_coord(:,1)+fr_str*delta_t;

circ_coord_cell(i,1)={temp_circ_coord};
circ_cell(i,1)={circulation};

i=i+1;

start;
k

%Enable lines 83 and 84 to get flow simulation
end

figure(1)
plot(h_d,h_v)
title('Phase potrait')
xlabel('Displacement (m)')
ylabel('plunge velocity (m/s)')
figure(2)
plot(delta_t*((0:p)'),h_d)
title('Time history of Displacement')
xlabel('Time (s)')
ylabel('Displacement (m)')
figure(3)
plot(delta_t*((0:p)'),atand(h_v./fr_str))
title('Time history of effective angle of attack')
xlabel('Time (s)')
ylabel('aoa (deg)')
figure(4)
plot(delta_t*((0:p)'),Lift)
title('Time history of Lift')
xlabel('Time (s)')
ylabel('Lift (N/m)')


 %plott





    
    
