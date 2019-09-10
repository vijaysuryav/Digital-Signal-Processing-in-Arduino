clc;
clear all;
close all;

fs = 600; %sampling frequency in Hz
t = 0:1/fs:1-1/fs; %time base
N = fs;
for k=1:fs/3
    x(k)=sin(2*pi*20*t(k));
end
for k=fs/3+1:2*fs/3
    x(k)=sin(2*pi*40*t(k));
end
for k=2*fs/3+1:fs
    x(k)=sin(2*pi*60*t(k));
end


subplot(3,1,1);plot(t,x); %Modulated Signal
title('Modulated signal'); xlabel('n'); ylabel('x(n)');

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

for k=N/2:N-1
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
subplot(3,1,3); plot(t, (imag(hilbert_z)));  % hilbert_z from inbulit command
title('Hilbert from inbulit command'); xlabel('n'); ylabel('Hilbert_inbuilt(n)');

inst_amplitude = abs(z); %envelope extraction
inst_phase = unwrap(angle(z));%inst phase
inst_freq = diff(inst_phase)/(2*pi)*fs;%inst frequency

figure();
plot(inst_freq); %overlay the extracted envelope
title('Extracted freq'); xlabel('n'); ylabel('IF');

