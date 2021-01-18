% This function returns Simulated Bit error rate and Thereotical Bit Error Rate
% for given values of SNR values for QPSK constellation with gray labelling 
% and without gray labelling 
% Inputs: yy - constellation symbols for computing BER 
% Inputs: type - 0 for gray and 1 for without gray labelling
% Inputs: x - the original binary signal transmitted
% Inputs: N - Number of binary bits in the original signal x
% Output: BER_SIM - Simulated Bit Error Rate
% Output: BER_TH - Thereotical Bit Error Rate
function [BER_SIM,BER_TH]= BERSNR(yy,type,x,N)
%Initialise Simulated Bit Error rate
BER_SIM=[];
%Initialise Thereotical Bit Error rate
BER_TH=[];
%Start the loop for different values of SNR
for EbN0dB =0:0.5:20
%Covert SNR in dB form to linear scale
EbN0=10^(EbN0dB/10);
%generate complex gaussian noise 
n=(1/sqrt(2))*[randn(1,length(yy))+1j*randn(1,length(yy))]; 
%variance : sqrt(1/((log2(M))*EbN0)) , here M=4, so log2(M) = 2
sigma = sqrt(1/(2*EbN0));
%as the noise is AWGN, it is added to the signal
r = yy+sigma*n; %final received signal

%Detection of received signal by ML distance method
%Distance of all the recieved symbols is computed from all the original
%symbols and the one with the minimum distance is detected
det=[]; %initialise detected signal
t=1/sqrt(2); % magnitude of original signal to be used for reference
%coordinates of original signal to be used for reference
org = [t+1j*t, -t+1j*t, -t+1j*-t, t+1j*-t];
%loop for every symbol of recieved signal
for mm=1:length(r)
    % find distance between symbols in received signal and original reference 
    for nn=1:length(org)
        a=((real(r(mm)) - real(org(nn)))^2);
        b=((imag(r(mm)) - imag(org(nn)))^2);
        err(nn)=sqrt(a+b);  %distance
    end
    %identified signal - find the index of the symbol with miniumum error
    %find the corresponding symbol from index from the original reference signal 
    iden = org(find(err==min(err)));    %identified symbols magnitude
    det = [det iden];   %detected signal
end
%Detection of symbols from the normalised magnitude
%Initialise the final detected symbol bits
x_cap=[];   %final detetcted received signal 
%Start loop for assigning symbols
for k=1:length(det)
    %if the coordinates are : (1/sqrt(2),1/sqrt(2))
    if real(det(k))==1/sqrt(2) && imag(det(k))==1/sqrt(2)
        d=[0 0];    %the detected symbol is 00
    %if the coordinates are : (-1/sqrt(2),1/sqrt(2))
    elseif  real(det(k))== -1/sqrt(2) && imag(det(k))==1/sqrt(2)
        d=[0 1];    %the detected symbol is 01
    %if the coordinates are : (-1/sqrt(2),-1/sqrt(2))
    elseif  real(det(k))== -1/sqrt(2) && imag(det(k))== -1/sqrt(2)
        if type==0 %gray labelling
            d=[1 1];    %the detected symbol is 11
        elseif type==1  %without gray labelling
            d=[1 0];    %detected symbol is 10
        end
    %if the coordinates are : (1/sqrt(2),-1/sqrt(2))
    elseif  real(det(k))== 1/sqrt(2) && imag(det(k))== -1/sqrt(2)
       if type==0 %gray labelling
            d=[1 0];    %the detected symbol is 11
        elseif type==1  %without gray labelling
            d=[1 1];    %detected symbol is 10
        end
    end
 % appending detetced symbols to the array
 x_cap = [x_cap d];  %final received signal 
end
%Bit Error Rate Computation
%Simulated ber : if the original signal is not equal to the final detected
%signal, it is error. ber_sim:average of all errors
ber_sim=sum(x~=x_cap)/N;    %ber_sim for a aprticular snr
BER_SIM=[BER_SIM ber_sim]   %add the ber_sim to the main array including all snrs
BER_TH=[BER_TH 0.5*((erfc(sqrt(EbN0)))-(1/4)*((erfc(sqrt(EbN0)))^2))];  %thereotical BER
end
end