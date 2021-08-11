function [e,f]=solveabc(a,bn,bwn,perimeter,lwt,tauk1,vstn,cn,csv)

b=perimeter*bwn/lwt-sum(bn,2);
c=-vstn-perimeter*tauk1*bwn/lwt-sum(repmat(csv',size(a,1),1).*cn,2);

e=a\b;
f=a\c;