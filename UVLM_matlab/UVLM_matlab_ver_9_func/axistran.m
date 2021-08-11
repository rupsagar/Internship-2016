function xt_yt=axistran(transfer_type,x_y,xpvt_ypvt,heave,pitch)

size_i=size(x_y,1);
if strcmp(transfer_type,'global_to_local')
% 'global_to_local' transforms the coordinates from global axis to local axis
    T=[cos(pitch) -sin(pitch);sin(pitch) cos(pitch)]; % transformation matrix ... pitch down is positive
    xt_yt=(x_y-repmat(xpvt_ypvt,size_i,1))*T+repmat([xpvt_ypvt(1) heave],size_i,1);
elseif strcmp(transfer_type,'local_to_global')
% 'local_to_global' transforms the coordinates from local axis to global axis
    T=[cos(pitch) sin(pitch);-sin(pitch) cos(pitch)]; % transformation matrix ... pitch down is positive
    xt_yt=(x_y-repmat(xpvt_ypvt,size_i,1))*T+repmat([xpvt_ypvt(1) -heave],size_i,1);
end