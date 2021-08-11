function [dx] = lorenz( t,x )
%tao=evalin('base','tao');
% load=evalin('base','temp_lift');
L=evalin('base','temp_lift');
% alpha=evalin('base','alpha');
% beta=evalin('base','beta');
% D=evalin('base','D');
m=evalin('base','m');
%w=evalin('base','w');

f=evalin('base','f');
omega=evalin('base','omega');

% dx(1,1)=x(2,1);
% dx(2,1)=(load/(m*D)+f*sin(omega*t)+beta*x(1,1)-alpha*x(1,1)^3);
% %dx(2,1)=D*(load/(m*D)+f*sin(omega*t)+beta*x(1,1)/D-alpha*x(1,1)^3/D^3);
dx=[x(2);
-(Ialp*Kh1*x(1)^3 + Ialp*Kh*x(1) - Kalp1*Salp*x(3)^3 - Kalp*Salp*x(3) + Ialp*L + M*Salp + Ch*Ialp*x(2) - Calp*Salp*x(4))/(- Salp^2 + Ialp*m);
x(4);
(Kh1*Salp*x(1)^3 + Kh*Salp*x(1) - Kalp1*m*x(3)^3 - Kalp*m*x(3) + M*m + L*Salp + Ch*Salp*x(2) - Calp*m*x(4))/(- Salp^2 + Ialp*m)];



end

