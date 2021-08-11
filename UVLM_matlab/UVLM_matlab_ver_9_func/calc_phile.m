function phile=calc_phile(aft,bft,bwft,qs,tau_nt,tauw,panlenf,cft,csv)

size_i=size(aft,1);

sum_aftq=sum(aft.*repmat(qs',size_i,1),2);
sum_bft=sum(bft,2);
sum_cft=sum(repmat(csv',size_i,1).*cft,2);

vphi=sum_aftq+tau_nt*sum_bft+tauw*bwft+sum_cft;
phile=-sum(vphi.*panlenf,1); % in book this sign was positive in Cebeci page 46,eqn 3.3.23