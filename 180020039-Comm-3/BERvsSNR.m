%XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%XXXXXXXX BER performance annalysis of BPSK modulation Technique XXXXXXXXX
%XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
clear;
%----------------------Parameters Initialisation---------------------%
%Number of bits or synmbols in the message signal
N = 10^6 % number of bits or symbols

rand('state',100); % initializing the rand() function
randn('state',200); % initializing the randn() function

% -----------------------Transmitter: Modulation----------------------%
%input message signal : Binary bits of 0s and 1s
ip = rand(1,N)>0.5; % generating 0,1 with equal probability
%BSPK Modulation: Convert into polar format(+1,-1)
s = 2*ip-1; % Mapping 0 -> -1; 1 -> 1 

%----------------------AWGN Initialisation----------------------------%
%generate complex white gaussian noise
n = 1/sqrt(2)*[randn(1,N) + j*randn(1,N)];  %complex awgn
%Set multiple values for SNR
Eb_N0_dB =0:0.1:10; % multiple Eb/N0 values
for ii = 1:length(Eb_N0_dB)
%Covert SNR in dB form to linear scale
EbN0=10.^(Eb_N0_dB(ii)/10);
%variance : sqrt(1/((log2(M))*EbN0)) , here M=2, so log2(M) = 1
sigma = sqrt(1/EbN0);
%as the noise is AWGN, it is added to the signal
y = s+sigma*n; %final received signal
   
   %receiver - hard decision decoding
   %creates a logical array, 1 if real(y)>0 and 0 if real(y)<0
   ipHat = real(y)>0; %decoded received signal

   % counting the errors i.e when ip and iphat bits are different
   %find number of nonzero elements in ip - iphat
   nErr(ii) = size(find([ip- ipHat]),2);

end
%BER : Error / number of bits
simBer = nErr/N; % simulated ber
%Thereotical BER using Q function
theoryBer = 0.5*erfc(sqrt(10.^(Eb_N0_dB/10))); % theoretical ber

%--------------------Plotting-----------------------------------%
close all
figure
semilogy(Eb_N0_dB,theoryBer,'b.-'); %plot thereotical values
hold on
semilogy(Eb_N0_dB,simBer,'mx-');    %plot simualted values
axis([0 10 10^-5 0.5])
grid on
legend('theory', 'simulation');
xlabel('Eb/No, dB');
ylabel('Bit Error Rate');
title('Bit error probability curve for BPSK modulation');