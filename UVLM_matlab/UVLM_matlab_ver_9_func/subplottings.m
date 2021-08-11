figure(1)

n_data = par.tot_time_step;

subplot(2,2,1), hold on, plot(ini.heave(1:n_data)/par.b,ini.heave_vel(1:n_data)/par.u_inf)
title(['Phase portrait \deltat=',num2str(par.dt),',U*=',num2str(par.u_star),',\mu=',num2str(par.mu),',f*=',num2str(par.f_star)])
xlabel('\xi')
ylabel('$\dot{\xi}$','interpreter','latex')
axis tight

subplot(2,2,2), hold on, plot(par.dtau*(0:n_data-1),ini.heave(1:n_data)/par.b)
title(['Time history of displacement \deltat=',num2str(par.dt),',U*=',num2str(par.u_star),',\mu=',num2str(par.mu),',f*=',num2str(par.f_star)])
xlabel('\tau')
ylabel('\xi')
axis tight

subplot(2,2,3), hold on, plot(par.dtau*(0:n_data-1),atand(ini.heave_vel(1:n_data)./par.u_inf))
title(['Time history of effective angle of attack \deltat=',num2str(par.dt),',U*=',num2str(par.u_star),',\mu=',num2str(par.mu),',f*=',num2str(par.f_star)])
xlabel('\tau')
ylabel('\alpha (in {\circ})')
axis tight

subplot(2,2,4), hold on, plot(par.dtau*(0:n_data-1),ini.CL(1:n_data))
title(['Time history of CL \deltat=',num2str(par.dt),',U*=',num2str(par.u_star),',\mu=',num2str(par.mu),',f*=',num2str(par.f_star)])
xlabel('\tau')
ylabel('\it{C_l}')
axis tight