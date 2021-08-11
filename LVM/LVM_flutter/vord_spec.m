function [u,v]=vord(tao,x,y,x_v,y_v)
r=(x-x_v).^2+(y-y_v).^2;
v=-(tao./(2*pi*r)).*(x-x_v);
u=(tao./(2*pi*r)).*(y-y_v);
end



