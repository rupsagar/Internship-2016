function [uw,vw]=setuvw(awx,awy,qs,bwx,bwy,tauk,vstwx,vstwy,cwx,cwy,csv)

size_i=size(awx,1);

sum_awxq=sum(awx.*repmat(qs',size_i,1),2);
sum_awyq=sum(awy.*repmat(qs',size_i,1),2);
sum_bwx=sum(bwx,2);
sum_bwy=sum(bwy,2);
sum_cwxt=sum(repmat(csv',size_i,1).*cwx,2);
sum_cwyt=sum(repmat(csv',size_i,1).*cwy,2);

uw=sum_awxq+tauk*sum_bwx+sum_cwxt+vstwx;
vw=sum_awyq+tauk*sum_bwy+sum_cwyt+vstwy;
