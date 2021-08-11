function [rhs,tangent_vel_rel_collac,v_w]=rhs_calc(circulation,circ_coord,collac_coord_abs,collac_coord_rel,parameters)
free_str=parameters(1);
theta=parameters(2);
theta_vel=parameters(3);

heave_vel=parameters(7);
n=size(collac_coord_rel,1);
n_tot=size(circulation,1);
circ_wake=circulation(n+2:n_tot,1);
circ_wake_coord=circ_coord(n+2:n_tot,:);
down_wash_wake=zeros(n,2);
for i=1:n
    [U_w,V_w]=vord(circ_wake,collac_coord_abs(i,1),collac_coord_abs(i,2),circ_wake_coord(:,1),circ_wake_coord(:,2));
    U_w=sum(U_w);
    V_w=sum(V_w);
    down_wash_wake(i,1)=U_w;
    down_wash_wake(i,2)=V_w;
end
v_w=down_wash_wake*([sin(theta),cos(theta)]');
vel_rhs=-free_str*sin(theta)*ones(n,1)+heave_vel*cos(theta)*ones(n,1)-theta_vel*collac_coord_rel(:,1)-v_w;
tangent_vel_rel_collac=free_str*cos(theta)*ones(n,1)+heave_vel*sin(theta)*ones(n,1)+down_wash_wake*([cos(theta) -sin(theta)]');
circulation_rhs=sum(circulation(1:n,1)); %for kelvin's circulation theorem
rhs=[vel_rhs;circulation_rhs];

end