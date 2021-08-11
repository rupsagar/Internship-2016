function [bound_vorticity]=bound_vort_calc(in_coeff,rhs)
bound_vorticity=linsolve(in_coeff,rhs);

