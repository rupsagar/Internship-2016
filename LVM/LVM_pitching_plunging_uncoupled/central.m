function central(amp_pitch,h)
% clc; clear all;
n=150;
c=1;
% fr_str=1;
delta_t=0.001;
p=1000; %number of iterations

k1=2;
w=20;
freq_pitch=w;
amp_heave=c*h;
freq_heave=w;
fr_str=w*c/(2*k1);

% amp_pitch=0.17;
% amp_heave=0.05;
% freq_pitch=0; %rad/s
% freq_heave=20; %rad/s

parameters=zeros(7,1);
parameters(1)=fr_str;
parameters(4)=delta_t;

[bound_vort_coord_rel,collac_rel]=plate_coord_calc(n,c);
influ_coeff=influ_coeff_calc(bound_vort_coord_rel,collac_rel);

circulation=zeros(n+5,1);
circ_coord=zeros(n+5,2);

wake_coord=[];
wake_vort=[];
temp_tangent_rel_vel_collac=zeros(n,1);
temp_v_w=zeros(n,1);
temp_bound_vort=zeros(n,1); %initial strength of the bound vortices
delta_p=zeros(p,1);
D_in=zeros(p,1);
Lift=zeros(p,1);
i=1;
ind=(n:-1:1)';
for k=0:p
    parameters(2)=amp_pitch*sin(freq_pitch*k*delta_t);
    parameters(3)=freq_pitch*(amp_pitch)*cos(freq_pitch*k*delta_t);
    parameters(5)=k;
    parameters(6)=amp_heave*sin(freq_heave*k*delta_t);
    parameters(7)=freq_heave*amp_heave*cos(freq_heave*k*delta_t);
    [bound_vort_coord_abs,collac_abs]=bound_vort_coord_calc(bound_vort_coord_rel,collac_rel,parameters); %to calculate the absolute coordinates of bound vortices and collocation points
    [rhs,tangent_rel_vel_collac,v_w]=rhs_calc(circulation,circ_coord,collac_abs,collac_rel,parameters);
    bound_vorticity=bound_vort_calc(influ_coeff,rhs);
    
    wake_vort=[bound_vorticity(n+1);wake_vort]; %adding the just shed vortex to the already present wake vortices
    bound_vorticity(n+1)=[];
    circulation=[bound_vorticity;wake_vort];
    bound_vort=bound_vorticity;
    wake_coord=[bound_vort_coord_abs(n+1,:);wake_coord];
    [wake_coord]=wake_coord_calc(circulation,bound_vort_coord_abs(1:n,:),wake_coord,delta_t);
    circ_coord=[bound_vort_coord_abs(1:n,:);wake_coord];
    delta_p(i,1)=1.28*(sum(temp_tangent_rel_vel_collac.*temp_bound_vort.*n./c)+sum((bound_vort-temp_bound_vort).*ind./delta_t));
    D_in(i,1)=1.28*sum(temp_v_w.*temp_bound_vort);
    temp_tangent_rel_vel_collac=tangent_rel_vel_collac;
temp_v_w=v_w;
temp_bound_vort=bound_vort;
CL(i,1)=delta_p(i,1)*c/n/(0.5*1.28*(fr_str^2)*c);
CT(i,1)=D_in(i,1)/(0.5*1.28*(fr_str^2)*c);
i=i+1;

plot(circ_coord(:,1),circ_coord(:,2),'.')
title(['kh=',num2str(k1*h),' \alpha=',num2str(amp_pitch),' h=',num2str(h),])

% pause(0.1)
k
end
saveas(gcf,['kh=',num2str(k1*h),'_alpha=',num2str(amp_pitch),'_h=',num2str(h),'.png']);