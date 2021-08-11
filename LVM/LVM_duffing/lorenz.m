function [dx] = lorenz( t,x )
%tao=evalin('base','tao');
load=evalin('base','temp_lift');
alpha=evalin('base','alpha');
beta=evalin('base','beta');
D=evalin('base','D');
m=evalin('base','m');
%w=evalin('base','w');

f=evalin('base','f');
omega=evalin('base','omega');

dx(1,1)=x(2,1);
dx(2,1)=(load/(m*D)+f*sin(omega*t)+beta*x(1,1)-alpha*x(1,1)^3);
%dx(2,1)=D*(load/(m*D)+f*sin(omega*t)+beta*x(1,1)/D-alpha*x(1,1)^3/D^3);



end

