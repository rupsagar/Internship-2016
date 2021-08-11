syms x1 x2 x3 x4 x_alp z_h w_bar u b_h r_alp z_alp u b_alp CL CM F pi mu
A=[1 0 0 0;
    0 1 0 x_alp;
    0 0 1 0;
    0 x_alp/r_alp^2 0 1];
B=[x2;
    -CL/(pi*mu)-(w_bar/u)^2*(x1+b_h*x1^3)-2*z_h*(w_bar/u)*x2+F;
    x4;
    2*CM/(pi*mu*r_alp^2)-2*z_alp/u*x4-(x3+b_alp*x3^3)/u^2];
C=linsolve(A,B)