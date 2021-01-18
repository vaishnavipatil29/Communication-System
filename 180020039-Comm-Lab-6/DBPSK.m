%-------------------------DBPSK-------------------------------%
%---------Generating bits--------%
N = 100000;   %number of bits
b = randi([0,1],1,N);    %generate random bits of 0s &1s

%-------Differential Encoding----%
d=randi([0 1],1); %Initial bit : randomly choose between 0 or 1

dc=[]; %initialise differential encoded modified transmitted bits
for i=1:length(b)
    dc=[dc d];   %append the delayed bit to the modified transmitted bits
    d=not(xor(d,b(i))); %computing the next bit of b : xnor
end
dc=[dc d]; %appending the last bit to the modified transmitted bits
%one bit is extra in dc than original b

%------Mapping/Modulation---------%
% Mapping 0 -> -1; 1 -> 1 
s = 2*dc-1; %modulated signal

%-------BER Computation----------%
BER_SIM=[]; %initialise simulated ber
BER_TH=[];  %initialise thereotical ber

%start the loop for snr
for EbN0dB =0:0.5:20
    
%----AWGN Channel------%
%convert dB to linear
EbN0=10^(EbN0dB/10);
%generate complex gaussian noise 
n=(1/sqrt(2))*[randn(1,length(s))+1j*randn(1,length(s))]; 
%variance : sqrt(1/((log2(M))*EbN0)) , here M=2, so log2(M) = 1
sigma = sqrt(1/EbN0);
%as the noise is AWGN, it is added to the signal
r = s+sigma*n; %final received signal

%------Detection--------%
%bpsk receiver-creates a logical array, 1 if real(y)>0 and 0 if real(y)<0
ipHat = real(r)>0;  %decoded received signal
%dbpsk detection
%loop is ran till length(ipHat)-1 as the final detected signal should have
%1 less bit than the bpsk detected signal
for ii=1:length(ipHat)-1
        if ipHat(ii)==ipHat(ii+1);  %if two consecutive bits are same the detcted bit is 1     
            op(ii)=1;
        else
            op(ii)=0;   %else it is 0
        end
end
ber_sim=sum(b~=op)/N;   %simulated ber : uncorrect detection between b and op
BER_SIM=[BER_SIM ber_sim]   %append the computed ber on 1 snr to other snr's ber
BER_TH=[BER_TH (erfc(sqrt(EbN0)))]  %thereotical ber
%twice the thereotical ber of bpsk as the difference is 3dB
%0.5*exp(-Eb/N0)
end
%------Ploting-----------%
EbN0dB =0:0.5:20;   
semilogy(EbN0dB,BER_SIM,'ro-',EbN0dB,BER_TH,'-');
xlabel('Eb/N0(dB)');
ylabel('BER');
legend('Simulation' , 'Theory')
axis([0 10 10^-5 10^0]);