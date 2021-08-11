if k<0.5
    c_theo1=1-0.165/(1-0.0455*1i/k)-0.335/(1-0.3*1i/k);
else
    c_theo1=1-0.165/(1-0.041*1i/k)-0.335/(1-0.32*1i/k);
end

c_theo=besselh(1,2,k)/(besselh(1,2,k)+1i*besselh(0,2,k));
cl_phasor=-(k^2)*(-2*amp_heave/c-amp_pitch)+1i*k*amp_pitch+2*pi*c_theo*(amp_pitch-1i*2*k*amp_heave/c-0.5*1i*k*amp_pitch);
arg=angle(cl_phasor);
amp=abs(cl_phasor);

    