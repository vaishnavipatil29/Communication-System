%The code implements frequency modulation and demodulation technique on the
%message signal.This involves altering phase and frequency of carrier signal.
%Envelope detection method is used for demodulation.

%------------------------- Generating Message signal------------------%
%Call msg.m file
m = msg();

%-----------------------------Parameters------------------------------%
Fs = 1.e4;   %Sampling frequency
Ts = 1/Fs;   %time steps
t = -0.04:Ts:0.04;  %time from -0.04 to 0.04 in ts steps
fc = 200;       %carrier frequency

%-----------------------------Modulation------------------------------%
%encoding information on a particular signal by varying the carrier wave
%frequency in accordance with the frequency of the modulating signal

%carrier wave
c = cos(2*fc*pi*t); 
%frequency sensitivity
kf = 80*Ts;    
%Integrating Msg to find phase
%func : cumsum calculates cumulative sum of elements
phase = kf*2*pi*cumsum(msg);  %phase
%modulated signal
fm = cos(2*fc*pi*t + phase);         % fm = cos(2*pi*fc*t + integral(msg))

%----------------------------Demodulation-----------------------------%
%Demodulation using envelope detection

%differentiating modulated signal 
%func : diff calculates difference between consecutive elements
%and approximate derivative.
dem = diff(fm); 
%length of modulated signal is reduced by 1 because of finding differences
%between consecutive elements. Hence add 0 to adjust the length.
dem = [0,dem]; 
%envelope detection
%func : envelope() initially removes the mean of  and restores it after
%computing the envelopes. 
rec_dem = abs(envelope(dem));  %recovered signal
%shift the demodulated signal by mean to adjust amplitude
rec_dem = rec_dem - mean(rec_dem);
%Scaling Factor for adjusting amplitude. Found by hit and trial.
Sf = 20;
rec_dem = Sf*rec_dem;   %Final recovered demodulated signal

%------------------------Frequency Domain------------------------------%
%---Parameters----%
f1 = length(t); %deciding frequency range length
f1 = 2^ceil(log2(f1)); %f1 as nearest power of 2
f = (-f1/2:f1/2-1)/(f1*1.e-4);      %assigning frequency range
%---Compute frequency domain signal--------%
mF = fftshift(fft(m,f1));   %message signal
fmF = fftshift(fft(fm,f1));   %modulated signal
rec_demF = fftshift(fft(rec_dem,f1));   %demodulated signal


%-----------------------Plotting signals in time domain-------------%
figure(1);
subplot(3,1,1);
plot(t,m);
title('Message Signal');
xlabel('time in sec');
ylabel('m(t)');
grid;

subplot(3,1,2);
plot(t,fm);
title(' Modulated Signal');
xlabel('time in sec');
ylabel('fm');
grid;

subplot(3,1,3);
plot(t,rec_dem);
title('Freq Demodulated Signal');
xlabel('time in sec');
ylabel('dem');
grid;



%--------------plotting signal in frequency domain-------------------%
figure(2);
subplot(3,1,1);
plot(f,abs(mF));
title('Message Signal');
xlabel('freq in Hz');
ylabel('M(f)');
grid;
axis([-600 600 0 200]);

subplot(3,1,2);
plot(f,abs(fmF));
title('Freq Modulated Signal');
xlabel('freq in Hz');
ylabel('FM(f)');
grid;
axis([-600 600 0 200]);

subplot(3,1,3);
plot(f,abs(rec_demF));
title('Freq Demodulated Signal');
xlabel('freq in Hz');
ylabel('demF');
grid;
axis([-600 600 0 200]);

%------------------Checking for Original and Received signal---------%
figure(3);
hold on;
plot(t,m,'r');
plot(t,rec_dem,'b');
legend('original signal','Final signal');
title('Checking for Original and Final Recovered Signal');
grid;
