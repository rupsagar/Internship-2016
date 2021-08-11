function duffing(gamma)

tspan=[0 50];
u0=[1 1];

% w=20;
% w_0=w*0.4;
% alpha=w_0^2/2;
% beta=w_0^2/2;
% p=@(t,y)([y(2);beta*y(1)-alpha*y(1)^3+gamma*sin(w*t)]);

p=@(t,y)([y(2);-y(2)+y(1)-y(1)^3+gamma*cos(t)]);

[t,y]=ode45(p,tspan,u0);

figure(1)
plot(t,y(:,1));
figure(2)
plot(y(:,1),y(:,2));