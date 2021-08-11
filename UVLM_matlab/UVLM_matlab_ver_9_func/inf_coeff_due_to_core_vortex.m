function [cn,ct]=inf_coeff_due_to_core_vortex(xm_ym,x_y,thetai)

size_i=size(xm_ym,1);
size_j=size(x_y,1);

xm_ym=repmat(xm_ym,[1,1,size_j]);
xm_ym=permute(xm_ym,[1,3,2]);
x_y=repmat(x_y,[1,1,size_i]);
x_y=permute(x_y,[3,1,2]);
diff=xm_ym-x_y;
rim=sqrt(sum((xm_ym-x_y).^2,3));
thetaij=atan2(diff(:,:,2),diff(:,:,1));
cond=thetaij<0;
thetaij(cond)=2*pi+thetaij(cond);
thetai=repmat(thetai,[1,size_j]);
thetaimj=thetai-thetaij;

cn=-cos(thetaimj)./(2*pi*rim);
ct=-sin(thetaimj)./(2*pi*rim);

cond=rim==0;
cn(cond)=0;
ct(cond)=0;