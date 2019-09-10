clc;
clear all;
close all;

fs = 600; %sampling frequency in Hz
t = -1:1/fs:1-1/fs; %time base
for k=1:length(t)
    x(k)=1/(1+t(k)^2);
end

subplot(3,1,1);plot(t,x); %Original Signal
title('Original signal'); xlabel('n'); ylabel('x(n)');

N=length(t);

for k=0:N-1
    for n=0:N-1
        y(n+1) = (x(n+1).*exp((-2*pi/N)*1j*n*k));
    end
    X(k+1) = sum(y);
    clear y;
    clear k;
end

for k=0:(N/2)-1
    X_h(k+1) = -j*X(k+1);
end

for k=(N/2):N-1
    X_h(k+1) = j*X(k+1);
end  

for n=0:N-1
    for k=0:N-1
        y(k+1) = (X_h(k+1).*exp((2*pi/N)*1j*n*k));
    end
    x_h(n+1) = sum(y)/N;
    z(n+1) = x(n+1) + j*x_h(n+1);
    clear y;
    clear k;
end
subplot(3,1,2); plot(t,(x_h)); % hilbert manual
title('Hilbert Manual'); xlabel('n'); ylabel('Hilbert_manual(n)');

hilbert_z = hilbert(x);
subplot(3,1,3); plot(t,(imag(hilbert_z)));  % hilbert_z from inbulit command
title('Hilbert from inbulit command'); xlabel('n'); ylabel('Hilbert_inbuilt(n)');



