function ini = structural_solver(par,ini,nt)

F = par.force*sin(par.omega_f*(nt-1)*par.dt);

ini.initial(nt,:) = [ini.heave(nt), ini.heave_vel(nt), ini.pitch(nt), ini.pitch_vel(nt)];

diff_eqn = @(t,x)[x(2);
    -(par.I_alp*par.Kh1*x(1)^3 + par.I_alp*par.Kh*x(1) - par.Kalp1*par.S_alp*x(3)^3 - par.Kalp*par.S_alp*x(3) + par.I_alp*(ini.L(nt) - F) + ini.M(nt)*par.S_alp + par.Ch*par.I_alp*x(2) - par.Calp*par.S_alp*x(4))/(- par.S_alp^2 + par.I_alp*par.mass_airfoil);
    x(4);
    (par.Kh1*par.S_alp*x(1)^3 + par.Kh*par.S_alp*x(1) - par.Kalp1*par.mass_airfoil*x(3)^3 - par.Kalp*par.mass_airfoil*x(3) + ini.M(nt)*par.mass_airfoil + (ini.L(nt) - F)*par.S_alp + par.Ch*par.S_alp*x(2) - par.Calp*par.mass_airfoil*x(4))/(- par.S_alp^2 + par.I_alp*par.mass_airfoil)];

[~,x] = ode45(diff_eqn,par.dt*[nt-1 nt],ini.initial(nt,:));

ini.h(nt+1) = x(end,1); ini.h_dot(nt+1) = x(end,2); ini.alp(nt+1) = x(end,3); ini.alp_dot(nt+1) = x(end,4);