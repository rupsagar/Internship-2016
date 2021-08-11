
tao=0;
f=360;
b=0.9;
l=1;
m=500;
D=sqrt(2*(1-b/l)/(b/l^3));
omega=20;
w=omega/0.4;  %4*K/m*(1-b/l);
alpha=w^2/2;
beta=w^2/2;



[t,x]=ode45('lorenz',[k*delta_t (k+1)*delta_t],x);

heave_disp=x(end,1)*D;
heave_vel=x(end,2)*D;
x=[x(end,1);x(end,2)];


