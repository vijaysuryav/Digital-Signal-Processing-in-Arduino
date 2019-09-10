clc;
clear all;
close all;

fs1 = 600; %sampling frequency in Hz
t1 = -2:1/fs1:2-1/fs1; %time base
fs2 = 600; %sampling frequency in Hz
t2 = -1:1/fs2:1-1/fs2; %time base
fs3 = 600; %sampling frequency in Hz
t3 = -3:1/fs3:3-1/fs3; %time base

for k=1:length(t1)
    x(k)=1/(1+t1(k)^2);
end
for k=1:length(t2)
    x(k+length(t1))=1/(1+2*t2(k)^2); 
end
for k=1:length(t3)
    x(k+length(t1)+length(t2))=1/(1+3*t3(k)^2);
end
t=[t1 t2+3 t3+7];
x_noisy=awgn(x,30);
subplot(3,1,1);plot(t,x_noisy); %Original AWGN Signal
%plot(t,t);
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

hilbert_z = hilbert(x_noisy);
subplot(3,1,3); plot(t,(imag(hilbert_z)));  % hilbert_z from inbulit command
title('Hilbert from inbulit command'); xlabel('n'); ylabel('Hilbert_inbuilt(n)');



