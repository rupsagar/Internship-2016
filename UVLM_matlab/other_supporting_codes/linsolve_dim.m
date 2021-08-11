syms m S_a I_a x1 x2 x3 x4 L M C_h K_h K_h1 C_a K_a K_a1 F
A=[1 0 0 0;
    0 m 0 S_a;
    0 0 1 0;
    0 S_a 0 I_a];
B=[x2;
    -L-K_h*x1-K_h1*x1^3-C_h*x2+F;
    x4;
    M-K_a*x3-K_a1*x3^3-C_a*x4];
C=linsolve(A,B);