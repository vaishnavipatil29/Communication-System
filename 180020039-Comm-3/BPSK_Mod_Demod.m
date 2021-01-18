%Binary Phase Shift Keying (BPSK) in Additive White Gaussian Noise (AWGN)
%BPSK Modulation and Demodulation Technique
clear;
%-------------------------Message : Information bits------------------%
%Generation of message signal : bits
N=10;%number of bits
%input binary data stream (0's and 1's) to modulate
msg=randi([0,1],N,1);%random bit generation (0 or 1)
%Plotting the message binary bits
figure(1);
subplot(6,1,1);
stem(msg);
title('Message : Binary bits');
grid;

%-----------------BPSK : Channel-Encoding and Modulation -------------%
% As in a noisy channel the conversion of 0 & 1 is quite possible,
%convert it into polar format(+1,-1)
mod = 2*msg-1; %BPSK modulation
%Plotting Mapped bits
subplot(6,1,2);
stem(mod);
title('Mapped bits');
grid;

%Form analog signal : add redundancy to the bits
samples_per_bit = 5; %replicate each bit samples_per_bit times
%form the transmitted signal by repeating each mapped bit samples_per_bit times
tx=repmat(mod,1, samples_per_bit).'; 
tx = tx(:).';%serialize
s_bb =tx;%BPSK modulated baseband signal
%Plotting the final Modulated and transmiited signal
t=0:N*samples_per_bit-1; %initialising time for plotting
subplot(6,1,3);
plot(t,s_bb);
title('BPSK Modulated Signal');
grid;

%-----------------------AWGN Channel------------------------------------%
%signal to noise ratio 
snr = 10;
%Convert SNR(dB) to linear scale
snr = 10 .^ (snr / 10.0);
%Calculate signal power 
xpower = sum(s_bb .^ 2) ./ size(s_bb,2);  
%Calculate noise power = signal power/SNR
npower = xpower ./ snr;
%Generate random noise and scale it by square root of power
noise = (randn(size(s_bb,2),1) .* sqrt(npower))';
% Add noise to modulated signal
rx = noise + s_bb;   % Final received signal

subplot(6,1,4);
plot(t,rx);
title('After Channel : Rx');
grid;

%-------------------------Demodulation----------------------------------%
%decode the received signal
%integrate for samples_per_bit duration
x = conv(rx,ones(1,samples_per_bit));
%Sample at every samples_per_bit bits
x = x(samples_per_bit:samples_per_bit:end);
%threshold detector : bit > 0 : 1, bit<0 : 0
final_detected_msg = (x > 0); 
%plotting binary and polar form of received signal
subplot(6,1,5);
stem(2*final_detected_msg-1);
title('final detected msg polar');
grid;
subplot(6,1,6);
stem(final_detected_msg);
title('final detected msg');
grid;
