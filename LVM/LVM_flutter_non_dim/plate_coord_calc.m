function [bound_vort_coord_rel,collac_rel]=plate_coord_calc(n,c)
bound_vort=(c/(4*n)):(c/n):((4*n-3)*c/(4*n));
bound_vort=bound_vort';
%for latest wake vortex
bound_vort(n+1,1)=c;
bound_vort_coord_rel=[-c+bound_vort,zeros(n+1,1)];
collac=(3*c/(4*n)):(c/n):((4*n-1)*c/(4*n));
collac=collac';
collac_rel=[-c+collac,zeros(n,1)];
end




