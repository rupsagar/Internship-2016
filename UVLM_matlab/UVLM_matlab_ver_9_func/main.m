%% MAIN.M is a flow solver coupled with structural solver
% commenting STRUCTURAL_SOLVER along with line 10 and giving suitable values to lines 13 makes it a flow solver
profile on
clear

%% parameters and initialization

parameters;
initialize_initialconditions;

%% time step starts

% fid = fopen('output.txt','wt');

for nt = 1:par.tot_time_step
    
    disp(['TIME STEP = ',num2str(nt)]);
    
    ini = flow_solver(par,ini,nt);  
    ini = structural_solver(par,ini,nt);
    
%     fprintf(fid,'%d %f %f %f %f %f %f\n',nt,ini.CL(nt),ini.CD(nt),ini.heave(nt),ini.heave_vel(nt),ini.pitch(nt),ini.pitch_vel(nt));
    
end

% fid = fclose(fid);

save(['test_newgeo_',num2str(par.u_star),'_',num2str(par.dt),'_',num2str(par.tot_time_step),'_',num2str(par.f_star),'_',num2str(par.omega_bar_f),'.mat'],'par','ini')
profile viewer
profile off