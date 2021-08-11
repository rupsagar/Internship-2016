function [lift,D_in]=loads(tangent_rel_vel_collac,c,circ_cell,v_w,delta_t)
n=size(tangent_rel_vel_collac,1);
k=size(circ_cell,1);
bound_vort=zeros(n,k);
ind=(n:-1:1)';
for i=1:k
    temp=cell2mat(circ_cell(i,1));
    bound_vort(:,i)=temp(1:n,1);
    
end
delta_p=zeros(k-1,1);
D_in=zeros(k-1,1);
for i=1:k-1
    delta_p(i,1)=1.2*(sum(tangent_rel_vel_collac(:,i).*bound_vort(:,i).*n./c)+sum((bound_vort(:,i+1)-bound_vort(:,i)).*ind./delta_t));
    D_in(i,1)=1.2*sum(v_w(:,i).*bound_vort(:,i));
end

lift=delta_p*c/n;
