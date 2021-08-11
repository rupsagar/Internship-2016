function [xf_yf,xmidf_ymidf,panlenf]=frontpanels(fmax,npan,pitch,panlen)

xf_yf=zeros(fmax,2);
panlenf=zeros(fmax-1,1);
xf_yf(2,:)=xf_yf(1,:)-panlen(npan/2)*[cos(pitch) sin(pitch)];
panlenf(1)=sum(sqrt((xf_yf(2,:)-xf_yf(1,:)).^2),2);

for i=3:fmax
    xf_yf(i,:)=xf_yf(i-1,:)-1.02*panlenf(i-2)*[cos(pitch) sin(pitch)];
 	panlenf(i-1)=sqrt(sum((xf_yf(i,:)-xf_yf(i-1,:)).^2,2));
end

xmidf_ymidf=0.5*(xf_yf(2:end,:)+xf_yf(1:end-1,:));
