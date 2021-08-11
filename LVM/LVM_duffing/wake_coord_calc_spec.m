function [wake_vort_coord]=wake_coord_calc_spec(circulation,bound_vort_coord,wake_vort_coord,delta_t)
n=size(bound_vort_coord,1);
% for wake roll up
num_wake=size(circulation,1)-n;
wake_vort_coord_temp=zeros(num_wake,2);
for i=1:num_wake
   circu=circulation;
   circu(n+i,:)=[];
   w_v_c=wake_vort_coord;
   w_v_c(i,:)=[];
   circu_coord=[bound_vort_coord;w_v_c];
   [u,v]=vord(circu,wake_vort_coord(i,1),wake_vort_coord(i,2),circu_coord(:,1),circu_coord(:,2));
   u=sum(u);
   v=sum(v);
   wake_vort_coord_temp(i,:)=[u,v]*delta_t+wake_vort_coord(i,:);
end
wake_vort_coord=wake_vort_coord_temp;
   
    

