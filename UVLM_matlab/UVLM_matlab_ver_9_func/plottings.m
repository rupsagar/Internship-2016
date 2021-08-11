figure(1),hold on
plot(heave(1:nt)/b,heave_vel(1:nt)/u_inf)
title(['Phase portrait \delta\tau=',num2str(dtau),',U*=',num2str(u_star),',\mu=',num2str(mu),',f*=',num2str(f_star)])
xlabel('Non-dimensional displacement')
ylabel('Non-dimensional plunge velocity')
axis tight

figure(2),hold on
plot(dtau*(0:nt-1),heave(1:nt)/b)
title(['Time history of displacement \delta\tau=',num2str(dtau),',U*=',num2str(u_star),',\mu=',num2str(mu),',f*=',num2str(f_star)])
xlabel('Non-dimensional time')
ylabel('Non-dimensional displacement')
axis tight

figure(3),hold on
plot(dtau*(0:nt-1),atand(heave_vel(1:nt)./u_inf))
title(['Time history of effective angle of attack \delta\tau=',num2str(dtau),',U*=',num2str(u_star),',\mu=',num2str(mu),',f*=',num2str(f_star)])
xlabel('Non-dimensional time')
ylabel('Angle of Attack ({\circ})')
axis tight

figure(4),hold on
plot(dtau*(0:nt-1),CL(1:nt))
title(['Time history of CL \delta\tau=',num2str(dtau),',U*=',num2str(u_star),',\mu=',num2str(mu),',f*=',num2str(f_star)])
xlabel('Non-dimensional time')
ylabel('Non-dimensional lift')
axis tight