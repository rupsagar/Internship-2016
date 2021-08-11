function [uh,vh]=setuvh(ahx,ahy,qs,bhx,bhy,tauk,bwhx,bwhy,tauw,pitch,v_step,chx,chy,csv)

size_i=size(ahx,1);

sum_ahxq=sum(ahx.*repmat(qs',[size_i,1]),2);
sum_ahyq=sum(ahy.*repmat(qs',[size_i,1]),2);
sum_bhx=sum(bhx,2);
sum_bhy=sum(bhy,2);
sum_chxt=sum(repmat(csv',size_i,1).*chx,2);
sum_chyt=sum(repmat(csv',size_i,1).*chy,2);

uh=sum_ahxq+tauk*sum_bhx+sum_chxt+tauw*bwhx+v_step*cos(pitch);
vh=sum_ahyq+tauk*sum_bhy+sum_chyt+tauw*bwhy+v_step*sin(pitch);