%XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%XXXX 16 - QAM Gray labelling :  BER vs SNR Plot   XXXXX
%XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
close all;

%-------------------Data to be sent--------------------------------%
N = 4*10000; %Number of bits in the input signal
x= randi([0,1],1,N);    %randomly generate bits of 0,1
M=16; %number of symbols
bits = log2(M); %Number of bits per symbols

%---------Modulation/ QAM Constellation : Gray labelling-----------%
%16-QAM constellation has 16 symbols mapped to different phases and
%amplitudes 
%initialise tx as empty array for storing gray labelling constellation
tx=[]; %transmitted signal;  
%Gray labelling 
%Normalizing factor for energy : sqrt(1/10) is multiplied to all symbols
for i=1:bits:length(x)
    %first quadrant
     if x(i)==1 && x(i+1)==1 && x(i+2)==1 && x(i+3)==0
        y=(1/sqrt(10))*(1+1j*3); %Normalizing factor for energy : sqrt(1/10)
    elseif x(i)==1 && x(i+1)==0 && x(i+2)==1 && x(i+3)==0
        y=(1/sqrt(10))*(3+1j*3);    
    elseif x(i)==1 && x(i+1)==1 && x(i+2)==1 && x(i+3)==1
        y= (1/sqrt(10))*(1+1j*1);  
    elseif x(i)==1 && x(i+1)==0 && x(i+2)==1 && x(i+3)==1
        y=(1/sqrt(10))*(3+1j*1); 
        
       %second quadrant
    elseif x(i)==0 && x(i+1)==0 && x(i+2)==1 && x(i+3)==0
        y=(1/sqrt(10))*(-3+1j*3);
    elseif x(i)==0 && x(i+1)==1 && x(i+2)==1 && x(i+3)==0
        y=(1/sqrt(10))*(-1+1j*3);
    elseif x(i)==0 && x(i+1)==0 && x(i+2)==1 && x(i+3)==1
        y=(1/sqrt(10))*(-3+1j*1);
    elseif x(i)==0 && x(i+1)==1 && x(i+2)==1 && x(i+3)==1
        y=(1/sqrt(10))*(-1+1j*1);
        
        %third quadrant
    elseif x(i)==0 && x(i+1)==0 && x(i+2)==0 && x(i+3)==1
        y=(1/sqrt(10))*(-3+1j*-1);
    elseif x(i)==0 && x(i+1)==1 && x(i+2)==0 && x(i+3)==1
        y=(1/sqrt(10))*(-1+1j*-1);
    elseif x(i)==0 && x(i+1)==0 && x(i+2)==0 && x(i+3)==0
        y=(1/sqrt(10))*(-3+1j*-3);
    elseif x(i)==0 && x(i+1)==1 && x(i+2)==0 && x(i+3)==0
        y=(1/sqrt(10))*(-1+1j*-3);
        
        %fourth quadrant
    elseif x(i)==1 && x(i+1)==1 && x(i+2)==0 && x(i+3)==1
        y=(1/sqrt(10))*(1+1j*-1);
    elseif x(i)==1 && x(i+1)==0 && x(i+2)==0 && x(i+3)==1
        y=(1/sqrt(10))*(3+1j*-1);
    elseif x(i)==1 && x(i+1)==1 && x(i+2)==0 && x(i+3)==0
        y=(1/sqrt(10))*(1+1j*-3);
    elseif x(i)==1 && x(i+1)==0 && x(i+2)==0 && x(i+3)==0
        y=(1/sqrt(10))*(3+1j*-3);
    end
    tx=[tx y];  %appending to the transmitted signal array
end
%scatterplot(yy)
ber_th=[];  %Initialise Thereotical Bit Error rate
ber_sim=[]; %Initialise Simulated Bit Error rate
%Start the loop for different values of SNR
%-------------------------BER Computation------------------------------% 
for EbN0dB=0:0.5:15
    %---------------------AWGN Channel----------------------%
EbN0 = 10^(EbN0dB/10); %Converting dB to linear scale
n=(1/sqrt(2))*[randn(1,length(tx))+1j*randn(1,length(tx))]; %generating gaussian complex noise
sigma = sqrt(1/(4*EbN0));%%variance : sqrt(1/((log2(M))*EbN0)) , here M=16, so log2(M) = 4
%as the noise is AWGN, it is added to the signal
r = tx+sigma*n; %final received signal
%-------------------------detection of bits------------------%
%set of possible transmitted symbols
%coordinates of original signal to be used for reference
org = sqrt(1/10)*[(-3+1j*3) (-1+1j*3) (-3+1j*1) (-1+1j*1) (1+1j*3) (3+1j*3) (1+1j*1) (3+1j*1) (1+1j*-1) (3+1j*-1) (1+1j*-3) (3+1j*-3) (-1+1j*-1) (-3+1j*-1) (-1+1j*-3) (-3+1j*-3)]
%scatterplot(org)
det=[] %Initialising detected signal
for mm=1:length(r)
    % find distance between symbols in received signal and original reference 
    for nn=1:length(org)
        a=((real(r(mm)) - real(org(nn)))^2);
        b=((imag(r(mm)) - imag(org(nn)))^2);
        err(nn)=sqrt(a+b);  %distance
    end
    %identified signal - find the index of the symbol with miniumum error
    %find the corresponding symbol from index from the original reference signal 
    iden = org(find(err==min(err)));   %identified symbols magnitude
    det = [det iden];   %detected signal
end
x_cap=[];   %final detetcted received signal 
%Start loop for assigning symbols
for k=1:length(det)
    %second quadrant
    if real(det(k))==(1/sqrt(10))*-3 && imag(det(k))==(1/sqrt(10))*3
        d=[0 0 1 0];    
    elseif real(det(k))==(1/sqrt(10))*-3 && imag(det(k))==(1/sqrt(10))*1
        d=[0 0 1 1]; 
    elseif real(det(k))==(1/sqrt(10))*-1 && imag(det(k))==(1/sqrt(10))*3
        d=[0 1 1 0];
    elseif real(det(k))==(1/sqrt(10))*-1 && imag(det(k))==(1/sqrt(10))*1
        d=[0 1 1 1];
        
      %first quadrant  
    elseif real(det(k))==(1/sqrt(10))*1 && imag(det(k))==(1/sqrt(10))*3
        d=[1 1 1 0];
    elseif real(det(k))==(1/sqrt(10))*3 && imag(det(k))==(1/sqrt(10))*3
        d=[1 0 1 0];
    elseif real(det(k))==(1/sqrt(10))*1 && imag(det(k))==(1/sqrt(10))*1
        d=[1 1 1 1];
     elseif real(det(k))==(1/sqrt(10))*3 && imag(det(k))==(1/sqrt(10))*1
        d=[1 0 1 1];
        
       %third quarter 
     elseif real(det(k))==(1/sqrt(10))*-3 && imag(det(k))==(1/sqrt(10))*-1
        d=[0 0 0 1];
     elseif real(det(k))==(1/sqrt(10))*-3 && imag(det(k))==(1/sqrt(10))*-3
        d=[0 0 0 0];
     elseif real(det(k))==(1/sqrt(10))*-1 && imag(det(k))==(1/sqrt(10))*-1
        d=[0 1 0 1];
     elseif real(det(k))==(1/sqrt(10))*-1 && imag(det(k))==(1/sqrt(10))*-3
        d=[0 1 0 0];
        
        %fourth quadrant
     elseif real(det(k))==(1/sqrt(10))*1 && imag(det(k))==(1/sqrt(10))*-1
        d=[1 1 0 1];
     elseif real(det(k))==(1/sqrt(10))*1 && imag(det(k))==(1/sqrt(10))*-3
        d=[1 1 0 0];
     elseif real(det(k))==(1/sqrt(10))*3 && imag(det(k))==(1/sqrt(10))*-1
        d=[1 0 0 1];
     elseif real(det(k))==(1/sqrt(10))*3 && imag(det(k))==(1/sqrt(10))*-3
        d=[1 0 0 0];
    end
   % appending detetced symbols to the array
 x_cap = [x_cap d];  %final received signal 
end
%Bit Error Rate Computation
%Simulated ber : if the original signal is not equal to the final detected
%signal, it is error. ber_sim:average of all errors
ber = sum(x~=x_cap)/N; %ber_sim for a particular snr
ber_sim = [ber_sim ber] %add the ber_sim to the main array including all snrs
M=16; % Number of symbols
b = log2(M); %no of bits per symbol
ber_th=[ber_th (1/b)*2*(1-sqrt(1/M))*erfc(sqrt((3*b*EbN0)/(2*(M-1))))]; % Thereotical ber
end
%-----------------Plot---------------------------------------------%
EbN0dB =0:0.5:15;% SNR values
semilogy(EbN0dB,ber_sim,'ro-',EbN0dB,ber_th,'-');%plot
xlabel('Eb/N0(dB)');
ylabel('BER');
title('16 QAM : With Gray labelling')
legend('Simulation:Gray ', 'Theory')