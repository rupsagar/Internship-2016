function [vstn,vstt]=vstream(v_step,xm_ym,heave_vel,pitch,pitch_vel,thetaf)

size_i=size(xm_ym,1);

vstx=v_step*cos(pitch)*ones(size_i,1)-pitch_vel*xm_ym(:,2);
vsty=v_step*sin(pitch)*ones(size_i,1)+pitch_vel*xm_ym(:,1)+heave_vel;
nx=-sin(thetaf);
ny=cos(thetaf);
tx=cos(thetaf);
ty=sin(thetaf);
vstn=vstx.*nx+vsty.*ny;
vstt=vstx.*tx+vsty.*ty;