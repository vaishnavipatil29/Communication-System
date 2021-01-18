%XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%XXXX QPSK Modulation and Demodulation and BER vs SNR Plot  XXXXX
%XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

%QPSK modulation and demodulation implementation
%plot error probability and plot Bit Error Rate (BER) vs. Signal to Noise
%Ratio (SNR) curve
close all;
%-------------------Data to be sent--------------------------------%
%Input data : test.txt 
%The data is taken from a text file (.txt) and converted to binary.
text = fileread('test.txt') %read text from test.txt file
[binV, binS] = text2bin(text);  %convert text to binary form
x = binV;   %x is the binary vector form : input signal
N = length(x) %Number of bits in the input signal

% call function constellation_form for generating QPSK constellations 
% with and without gray labelling
% Inputs: x - The original binary bits signal 
% Output: gray : constellation with gray labelling
% Output: wogray : constellation without gray labelling
[gray wogray]= qpskconstellation(x);
%---------------BER vs SNR---------------------------------------%
% call function BERSNR - Computation of Simulated Bit error rate
%and Thereotical Bit Error Rate
% Inputs: yy - constellation symbols for computing BER 
% Inputs: type - 0 for gray and 1 for without gray labelling
% Inputs: x - the original binary signal transmitted
% Inputs: N - Number of binary bits in the original signal x
% Output: BER_SIM - Simulated Bit Error Rate
% Output: BER_TH - Thereotical Bit Error Rate
[BER_SIM_G,BER_TH] = BERSNR(gray,0,x,N) %gray labelling
[BER_SIM_WOG,BER_TH] = BERSNR(wogray,1,x,N) %without gray labelling
%-----------------Plot---------------------------------------------%
EbN0dB =0:0.5:20;% SNR values
semilogy(EbN0dB,BER_SIM_G,'ro-',EbN0dB,BER_SIM_WOG,'ko-',EbN0dB,BER_TH,'-');%plot
xlabel('Eb/N0(dB)');
ylabel('BER');
legend('Simulation:Gray ','Simulation : Without Gray' , 'Theory')
axis([0 10 10^-5 10^0]);