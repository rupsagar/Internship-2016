%% user input parameters
%% variable parameter
par.dt = 0.001; % (**) time interval
par.tot_time_step = 2001; % (**) total number of time steps (taking no_of_cycle = 10; approx. tot_time_step = (2*pi/omega_alp)*no_of_cycle/dt)

par.c = 1; % (**) chord length (in m)

par.mu = 40; % (**) non dimensional mass (in fortran 41.383322650519760, we might be taking 5)

par.core_vort_upto = Inf; % times of chord length upto which the core vortices are considered

par.npan = 400; % (**) number of panels the airfoil is divided into
par.fmax = 400; % (**) number of front panels

par.u_star = 5; % (**) non dimensional free stream velocity

par.omega_u1 = sqrt(0); % dimensional frequency of wind component 1
par.omega_u2 = sqrt(0); % dimensional frequency of wind component 2
par.omega_u3 = sqrt(0); % dimensional frequency of wind component 3

par.omega_alp = 100; % (**) (in rad/s)
par.omega_bar = 0.2; %(**) omega_bar = omega_eps/omega_alp

par.f_star = 21e-4; % (**) non dimensional external force (for the present study 2e-5(100), 6.25e-4(3000), 12.5e-4(6000), 19e-4(9000), 21e-4(10000), 23e-4(11000), 25e-4(12000))
par.omega_bar_f = 0.1; % (**) non dimensional frequency of external force (for the present study dimensionally 50 rad/s)

%% fluid density parameter
par.rho_air = 1.22586; % density of air (in kg/m^3)

%% iteration parameter
par.itermax = 30; % number of iterations for convergence of the uniform vortex sheet strength on the airfoil

%% structural parameter
par.zeta_eps = 0.0;
par.zeta_alp = 0.0;
par.beta_eps = 0.0;
par.beta_alp = 3.0;

%% calculated parameters
%% geometrical & influence_coefficient parameter
par.b = par.c/2; % (**) semi chord length (in m)

par.xpvt_ypvt = [0.25 0]*par.c; % (**) x & y coordinate of aerodynamic centre wrt local system (in m)

[par.xaf_yaf,par.xmaf_ymaf,par.panlen,par.perimeter,par.theta_af] = geometry(par.c,par.npan);  % geometry.f
[par.an,par.at,par.bn,par.bt] = inf_coeff_due_to_panel('due_to_airfoil_panel',par.xmaf_ymaf,par.xaf_yaf,par.theta_af,par.theta_af);  % stantbnt.f

%% non-dimensional time
par.dtau = par.u_star*par.omega_alp*par.dt; % dtau = dt*u_inf/b = u_star*omega_alp*dt

%% dynamic parameter
par.u_inf = par.u_star*par.omega_alp*par.b; % free stream velocity (in m)

par.u_step = par.u_inf*(1+sin(par.omega_u1*(0:par.tot_time_step-1)*par.dt)+sin(par.omega_u2*(0:par.tot_time_step-1)*par.dt)+sin(par.omega_u3*(0:par.tot_time_step-1)*par.dt)); % (in m/s)

%% mass & inertial parameter
par.ind = par.npan/2;

par.mass_airfoil = pi*par.rho_air*par.mu*par.b^2; % dimensional mass (in kg)

par.area_each_trapezium = -(par.xaf_yaf(1:par.ind,2)+par.xaf_yaf(2:par.ind+1,2)).*(par.xaf_yaf(1:par.ind,1)-par.xaf_yaf(2:par.ind+1,1)); % area of each trapezoidal section of airfoil between two consecutive x coordinate
par.area_airfoil = sum(par.area_each_trapezium,1); % total area of airfoil

par.rho_airfoil = par.mass_airfoil/par.area_airfoil; % density of airfoil

par.mass_each_trapezium = par.area_each_trapezium*par.rho_airfoil; % mass of each trapezoidal section of airfoil between two consecutive x coordinate

par.S_alp = sum(par.mass_each_trapezium.*(par.xmaf_ymaf(1:par.ind,1)-par.xpvt_ypvt(1)),1); % first mass moment of inertia of airfoil about aerodynamic y axis
par.x_alp = par.S_alp/(par.mass_airfoil*par.b);

par.I_alp = sum(par.mass_each_trapezium.*(par.xmaf_ymaf(1:par.ind,1)-par.xpvt_ypvt(1)).^2,1); % second mass moment of inertia of airfoil about aerodynamic y axis
par.r_alp = sqrt(par.I_alp/(par.mass_airfoil*par.b^2));

%% structural parameters
par.Kh = par.mass_airfoil*((par.omega_bar*par.omega_alp)^2); % linear translational spring constant
par.Kalp = par.I_alp*(par.omega_alp^2); % linear torsional spring constant
par.Ch = 2*par.zeta_eps*sqrt(par.Kh*par.mass_airfoil); % translational spring dampening coefficient
par.Calp = 2*par.zeta_alp*sqrt(par.Kalp*par.I_alp); % torsional spring dampening coefficient
par.Kh1 = par.beta_eps*par.Kh; % non-linear translational spring constant 
par.Kalp1 = par.beta_alp*par.Kalp; % non-linear torsional spring constant

%% external_forcing parameter
par.force = par.f_star*(par.mass_airfoil*par.u_inf^2/par.b); % dimensional external force (in N)
par.omega_f = par.omega_bar_f*par.u_inf/par.b; % dimensional external forcing frequency (in rad/s)
