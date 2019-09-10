clear all;
close all;
clc;

x=[2 3 4 2 5 6 3 4 4 7 98 1  5 6 3 4];

q=dif_meghna(x);
e=dit_meghna(x);
figure;
subplot(3,1,1);
stem(q); title('DIF FFT result');
subplot(3,1,2);
stem(e); title('DIT FFT result');
Y_fft = fft(x,16);
subplot(3,1,3);
stem((Y_fft)); title('MATLAB function FFT result');