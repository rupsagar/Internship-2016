function [an,at,bn,bt]=inf_coeff_due_to_panel(for_panel_type,xm_ym,x_y,thetai,thetaj)

size_i=size(thetai,1);
size_j=size(thetaj,1);
thetaimj=repmat(thetai,1,size_j)-repmat(thetaj',size_i,1);

xm_ym=repmat(xm_ym,[1,1,size_j+1]);
xm_ym=permute(xm_ym,[1,3,2]);
x_y=repmat(x_y,[1,1,size_i]);
x_y=permute(x_y,[3,1,2]);
diff=xm_ym-x_y; % generates a grid where first 3-plane contains the difference between the x coordinates and second 3-plane contains the difference between the y coordinate ... while on a plane along a row we get the difference of a midpoint from the influencing point
r=sqrt(sum((xm_ym-x_y).^2,3));
rijp_rij=r(:,2:end)./r(:,1:end-1);
betaij=atan2(diff(:,2:end,2).*diff(:,1:end-1,1)-diff(:,2:end,1).*diff(:,1:end-1,2),...
    diff(:,2:end,1).*diff(:,1:end-1,1)+diff(:,2:end,2).*diff(:,1:end-1,2));

if strcmp(for_panel_type,'due_to_airfoil_panel')
    an=(sin(thetaimj).*log(rijp_rij)+cos(thetaimj).*betaij)/(2*pi);
    at=(-cos(thetaimj).*log(rijp_rij)+sin(thetaimj).*betaij)/(2*pi);
    if size_i==size_j
        an(size_i*(0:size_i-1)+(1:size_i))=0.5;
        at(size_i*(0:size_i-1)+(1:size_i))=0.0;
    end
    bn=-at;
    bt=an;
elseif strcmp(for_panel_type,'due_to_shed_vortex_panel')
    an=0;
    at=0;
    bn=(cos(thetaimj).*log(rijp_rij)-sin(thetaimj).*betaij)/(2*pi);
    bt=(sin(thetaimj).*log(rijp_rij)+cos(thetaimj).*betaij)/(2*pi);
end