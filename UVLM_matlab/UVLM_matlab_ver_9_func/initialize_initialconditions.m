%% initialize
ini.xsv_ysv = zeros(par.tot_time_step,2); % global coordinate of the core vortices at any time step
ini.xsvt_ysvt = zeros(par.tot_time_step,2); % local coordinate of the core vortices at any time step

ini.chord_20_cell = cell(par.tot_time_step,1);
ini.absolute_coord = cell(par.tot_time_step,1); % stores the global coordinates of airfoil nodes & core vortices at all time steps

ini.CL = zeros(par.tot_time_step,1); % coefficient of lift at any time step
ini.CD = zeros(par.tot_time_step,1); % coefficient of drag at any time step
ini.CM = zeros(par.tot_time_step,1); % coefficient of moment at any time step
ini.L = zeros(par.tot_time_step,1); % lift generated at any time step
ini.M = zeros(par.tot_time_step,1); % moment generated at any time step

ini.heave = zeros(par.tot_time_step,1); % total heave
ini.heave_vel = zeros(par.tot_time_step,1); % total heave velocity
ini.pitch = zeros(par.tot_time_step,1); % total pitch
ini.pitch_vel = zeros(par.tot_time_step,1); % total pitch velocity
    
ini.h = zeros(par.tot_time_step+1,1); % heave from structural solver
ini.h_dot = zeros(par.tot_time_step+1,1); % heave velocity from structural solver
ini.alp = zeros(par.tot_time_step+1,1); % pitch from structural solver
ini.alp_dot = zeros(par.tot_time_step+1,1); % pitch velocity from structural solver

ini.initial = zeros(par.tot_time_step,4); % itial condition for structural solver

ini.lw = zeros(par.tot_time_step,1); % length of shed vortex panel at any time step
ini.ow = zeros(par.tot_time_step,1); % angle of inclination of shed vortex panel with local x axis at any time step
ini.tau = zeros(par.tot_time_step,1); % strength of uniform vortex sheet on the airfoil at any time step
ini.csv = zeros(par.tot_time_step,1); % strength of the core vortex formed at any time step 

ini.phiairfoil = zeros(par.npan+1,1); % stores the potential at the airfoil nodes wrt to leading edge
ini.phi = zeros(par.npan,par.tot_time_step); % stores the absolute potential at the midpoint of each airfoil panel

%% itial conditions
% (**) itial condition for structural solver ... comment for simulating flow solver
ini.h(1) = 0; ini.h_dot(1) = 0; ini.alp(1) = 4*pi/180; ini.alp_dot(1) = 0.001;

% (**) itial condition for flow solver ... make the frequencies zero for coupling structure
ini.amp_heave = -0.05; ini.freq_heave = 0.0; ini.amp_pitch = 0.17; ini.freq_pitch = 0.0;