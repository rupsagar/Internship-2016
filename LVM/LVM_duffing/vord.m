function [u,v]=vord(tao,x,y,x_v,y_v)

v=-(tao./(2*pi*((x-x_v).^2+(y-y_v).^2))).*(x-x_v);
u=(tao./(2*pi*((x-x_v).^2+(y-y_v).^2))).*(y-y_v);
end



