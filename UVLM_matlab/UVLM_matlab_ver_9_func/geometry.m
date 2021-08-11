function [xaf_yaf,xmaf_ymaf,panlen,perimeter,theta_af] = geometry(c,npan)

% refer https://turbmodels.larc.nasa.gov/naca0012_val.html for NACA 0012 equation

dtheta = 2*pi/npan;
x = 0.5+0.5*cos(2*pi-dtheta*(0:npan));

i = npan/2;
y = zeros(1,npan+1);
y(1) = 0; y(i+1) = 0;
y(2:i) = -0.6*(0.2969*sqrt(x(2:i))-0.1260*x(2:i)-0.3516*(x(2:i).^2)+0.2843*(x(2:i).^3)-0.1015*(x(2:i).^4)); % -0.0021 is omitted from the fortran formula
y(i+2:npan) = -y(i:-1:2);

xaf_yaf = [x',y']*c;

xmaf_ymaf = 0.5*(xaf_yaf(1:npan,:)+xaf_yaf(2:npan+1,:));
panlen = sqrt(sum((xaf_yaf(1:npan,:)-xaf_yaf(2:npan+1,:)).^2,2));
perimeter = sum(panlen,1);
theta_af = atan2(xaf_yaf(2:npan+1,2)-xaf_yaf(1:npan,2),xaf_yaf(2:npan+1,1)-xaf_yaf(1:npan,1));
cond = theta_af < 0;
theta_af(cond) = theta_af(cond)+2*pi;