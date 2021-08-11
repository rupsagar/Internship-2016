function [bound_vort_coord_abs,collac_coord_abs]=bound_vort_coord_calc(bound_vort_rel,collac_rel,parameters)
free_str=parameters(1);
theta=parameters(2);
delta_t=parameters(4);
heave_disp=parameters(6);
%loop number
n_t=parameters(5);
bound_vort_coord_abs=[-free_str*delta_t*n_t*ones(size(bound_vort_rel(:,2))),heave_disp*ones(size(bound_vort_rel(:,2)))]+[bound_vort_rel(:,1)*cos(theta),bound_vort_rel(:,1)*sin(-theta)];
collac_coord_abs=[-free_str*delta_t*n_t*ones(size(collac_rel(:,2))),heave_disp*ones(size(collac_rel(:,2)))]+[collac_rel(:,1)*cos(theta),collac_rel(:,1)*sin(-theta)];
end

