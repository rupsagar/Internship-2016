function [in_coeff]=influ_coeff_calc(bound_vort,collac)
x_vort=bound_vort(:,1);
y_vort=bound_vort(:,2);
x_collac=collac(:,1);
y_collac=collac(:,2);
n=size(collac,1);
in_coeff=zeros(n,n+1);
for i=1:n
    y=y_collac(i,1)*ones(n+1,1);
    x=x_collac(i,1)*ones(n+1,1);
    [~,v]=vord(1,x,y,x_vort,y_vort);
    in_coeff(i,:)=v;
end
in_coeff(n+1,:)=ones(n+1,1);
end

    





