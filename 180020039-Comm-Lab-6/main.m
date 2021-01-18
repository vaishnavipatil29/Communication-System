%-------------------------DQPSK----------------------------%
close all;
%-------------------Generating bits-----------%
%number of binary bits of 0s and 1s  
N = 99999;
% call function constellation_form for generating random bits, does differential endoding and mapping
% and generates DQPSK constellations with and without gray labelling
% Inputs: N - Number of binary bits to be generated 
% Output: x : randomly generated binary bits : original signal
% Output: gray : constellation with gray labelling
% Output: wogray : constellation without gray labelling
[x gray wogray]= dqpskconstellation(N);
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
semilogy(EbN0dB,BER_SIM_G,'ro-',EbN0dB,BER_SIM_WOG,'ko-',EbN0dB,2*BER_TH,'-');%plot
xlabel('Eb/N0(dB)');
ylabel('BER');
title('DQPSK')
legend('Simulation:Gray ','Simulation : Without Gray' , 'Theory')
axis([0 10 10^-5 10^0]);