function [wake_vort_coord]=wake_coord_calc(circulation,bound_vort_coord,wake_vort_coord,delta_t)



n=size(bound_vort_coord,1);
% for wake roll up
num_wake=size(circulation,1)-n;

w_v_c=wake_vort_coord';
w_v=circulation(n+1:end,1)';
b_c=circulation(1:n,1)';
b_c_c=bound_vort_coord';


w_v_c_x=repmat(w_v_c(1,:),num_wake,1);

w_v_c_y=repmat(w_v_c(2,:),num_wake,1);
w_v_mul=w_v(ones(num_wake,1),:);

b_c_mul=b_c(ones(num_wake,1),:);

b_c_c_x=repmat(b_c_c(1,:),num_wake,1);

b_c_c_y=repmat(b_c_c(2,:),num_wake,1);


w_v_mul=w_v_mul-eye(num_wake)*w_v_mul;
w_v_c_x=w_v_c_x-eye(num_wake)*1i;
w_v_c_y=w_v_c_y-eye(num_wake)*1i;

v_mul=[b_c_mul,w_v_mul];
c_c_x=[b_c_c_x,w_v_c_x];
c_c_y=[b_c_c_y,w_v_c_y];


t1=size(c_c_x,2);
w_v_c_vord_x=repmat(wake_vort_coord(:,1),1,t1);

w_v_c_vord_y=repmat(wake_vort_coord(:,2),1,t1);

%size(c_c_x)
%size(c_c_y)
%size(w_v_c_vord_x)
%size(w_v_c_vord_y)

%tao=v_mul;
%x=w_v_c_vord_x;
%y=w_v_c_vord_y;
%x_v=c_c_x;
%y_v=c_c_y;


%v=-(v_mul./(2*pi*((w_v_c_vord_x-c_c_x).^2+(w_v_c_vord_y-c_c_y).^2))).*(w_v_c_vord_x-c_c_x);
%u=(v_mul./(2*pi*((w_v_c_vord_x-c_c_x).^2+(w_v_c_vord_y-c_c_y).^2))).*(w_v_c_vord_y-c_c_y);

[u,v]=vord(v_mul,w_v_c_vord_x,w_v_c_vord_y,c_c_x,c_c_y);

temp1=u(:,n+1:end);
temp2=v(:,n+1:end);

temp1=temp1-eye(num_wake)*temp1;
temp2=temp2-eye(num_wake)*temp2;

u=[u(:,1:n),temp1];
v=[v(:,1:n),temp2];

u=sum(u,2);
v=sum(v,2);

wake_vort_coord=[u,v]*delta_t+wake_vort_coord;




%for i=1:num_wake
   %circu=circulation;
   %circu(n+i,:)=[];
   %w_v_c=wake_vort_coord;
   %w_v_c(i,:)=[];
   %circu_coord=[bound_vort_coord;w_v_c];
   %[u,v]=vord(circu,wake_vort_coord(i,1),wake_vort_coord(i,2),circu_coord(:,1),circu_coord(:,2));
   %u=sum(u);
   %v=sum(v);
   %wake_vort_coord_temp(i,:)=[u,v]*delta_t+wake_vort_coord(i,:);
%end
%wake_vort_coord=wake_vort_coord_temp;

end
   
    

