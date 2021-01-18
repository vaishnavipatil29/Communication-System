%This code implements Conventional Modulation and demodulation techniques
%carrier signal is multiplied by the message signal and then added by
%carrier signal( to remove supression at f=fc)
%This final signal is Conventional modulated signal
%The modulated signal is passed thrpugh a low pass filter
%The final signal is demodulated

%------------------------- Generating Message signal------------------%
%Call msg.m file
m = msg();
%------------------------ Generating carrier signal-------------------%
%call carrier.m file
[c,fc,Fs,Ac,t] = carrier();
%-----------------------------Modulation------------------------------%
%Modulated signal has a extra term of carrier signal, so that it is not
%supressed at fc
A = 2;  %constant value
mod = A*m.*c + c;    %modulated signal

%----------------------------Demodulation-----------------------------%
%Multiply modulated signal with carrier signal
dem = mod.*c ;   %demodulated signal

% -------------------Filtering out High Frequncies------------------%
rec = filters(fc,Fs,dem); %final recovered signal
rec = rec - 1/2*Ac; % Adjusting the impulse delta at f=fc

%-------------------Computing frequency domain----------------------%
%---Parameters----%
f1 = length(t); %deciding frequency range length
f1 = 2^ceil(log2(f1)); %f1 as nearest power of 2
f = (-f1/2:f1/2-1)/(f1*1.e-4);      %assigning frequency range
%---Compute frequency domain signal--------%
mF = fftshift(fft(m,f1));   %message signal
cF = fftshift(fft(c,f1));   %carrier signal
modF = fftshift(fft(mod,f1));   %modulated signal
demF = fftshift(fft(dem,f1));   %demodulated signal
recF = fftshift(fft(rec,f1));   %final recovered signal 


%------------------Plotting signals in time domain-----------------%
figure(1);
subplot(3,2,1);
plot(t,m);
title('Message Signal');
xlabel('time in sec');
ylabel('m(t)');
grid;

subplot(3,2,2);
plot(t,c);
title('Carrier Signal');
xlabel('time in sec');
ylabel('c(t)');
grid;

subplot(3,2,3);
plot(t,mod);
title('Conventional Modulated Signal');
xlabel('time in sec');
ylabel('mod');
grid;

subplot(3,2,4);
plot(t,dem);
title('Conventional Demodulated Signal');
xlabel('time in sec');
ylabel('dem');
grid;

subplot(3,2,5);
plot(t,rec);
title('Final Recovered Signal');
xlabel('time in sec');
ylabel('rec');
grid;

%plotting signal in frequency domain
figure(2);
subplot(3,2,1);
plot(f,abs(mF));
title('Message Signal');
xlabel('freq in Hz');
ylabel('M(f)');
grid;
axis([-600 600 0 200]);

subplot(3,2,2);
plot(f,abs(cF));
title('Carrier Signal');
xlabel('freq in Hz');
ylabel('C(f)');
grid;
axis([-600 600 0 200]);

subplot(3,2,3);
plot(f,abs(modF));
title('Conventional Modulated Signal');
xlabel('freq in Hz');
ylabel('mod(f)');
grid;
axis([-600 600 0 200]);

subplot(3,2,4);
plot(f,abs(demF));
title('Conventional Demodulated Signal');
xlabel('freq in Hz');
ylabel('demF');
grid;
axis([-600 600 0 200]);

subplot(3,2,5);
plot(f,abs(recF));
title('Final Recovered Signal');
xlabel('freq in Hz');
ylabel('rec');
grid;
axis([-600 600 0 200]);
%------------------Checking for Original and Received signal---------%
figure(3);
hold on;
plot(t,m,'r');
plot(t,rec,'b');
legend('original signal','Final signal');
title('Checking for Original and Final Recovered Signal');
grid;