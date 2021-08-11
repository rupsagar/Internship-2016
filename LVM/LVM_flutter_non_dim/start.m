
x1=x(1);x2=x(2);x3=x(3);x4=x(4);

 lorenz = @(t,x)[x2;
 -(CL*r_alp^2*u^2 + 2*pi*mu*x2*z_h*r_alp^2*u*w_bar - 2*pi*mu*x4*x_alp*z_alp*r_alp^2*u + pi*b_h*mu*r_alp^2*w_bar^2*x1^3 + pi*mu*r_alp^2*w_bar^2*x1 - pi*b_alp*mu*x_alp*r_alp^2*x3^3 - pi*mu*x_alp*r_alp^2*x3 + 2*CM*x_alp*u^2)/(pi*mu*u^2*(r_alp^2 - x_alp^2));
 x4;
 (2*CM*u^2 + CL*u^2*x_alp - pi*mu*r_alp^2*x3 - pi*b_alp*mu*r_alp^2*x3^3 + pi*mu*w_bar^2*x1*x_alp - 2*pi*mu*r_alp^2*u*x4*z_alp + pi*b_h*mu*w_bar^2*x1^3*x_alp + 2*pi*mu*u*w_bar*x2*x_alp*z_h)/(pi*mu*u^2*(r_alp^2 - x_alp^2))];

[tau,x]=ode45(lorenz,[k (k+1)]*delta_tau,x);
x=x(end,:);
 