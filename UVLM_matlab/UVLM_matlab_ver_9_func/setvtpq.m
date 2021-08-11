function [p,q]=setvtpq(at,bt,bwt,perimeter,lwt,e,f,tauk1,vstt,ct,csv)

size_i=size(at,1);

sum_ae=sum(at.*repmat(e',size_i,1),2);
sum_bt=sum(bt,2);
sum_af=sum(at.*repmat(f',size_i,1),2);
sum_ct=sum(repmat(csv',size_i,1).*ct,2);

p=sum_ae+sum_bt-perimeter*bwt/lwt;
q=sum_af+vstt+perimeter*tauk1*bwt/lwt+sum_ct;