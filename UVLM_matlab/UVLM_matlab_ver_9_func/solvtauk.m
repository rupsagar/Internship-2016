function tauk=solvtauk(p1,q1,pn,qn,perimeter,dt,tauk1,tauk_prev_iter)

aa=p1^2-pn^2;
bb=2*p1*q1-2*pn*qn-2*perimeter/dt;
cc=q1^2-qn^2+2*perimeter*tauk1/dt;
	
disc=bb^2-4*aa*cc;
	
if disc>0||disc==0
    r1=(-bb+sqrt(disc))/(2*aa);
    r2=(-bb-sqrt(disc))/(2*aa);
else
    r1=999.0;
	r2=999.0;
end

if abs(r1-tauk_prev_iter)<=abs(r2-tauk_prev_iter)
    tauk=r1;
else
    tauk=r2;
end