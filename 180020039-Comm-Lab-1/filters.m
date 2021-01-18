% This function applies a low pass filter and filters out high frequencies.
% Input:fc - Carrier frequency
% Input:Fs - Sampling Frequency/ Frequency steps
% Input:dem - Demodulated Signal
% The demodulated signal is filtered 
% Output: rec - final recovered signal signal
function rec = filters(fc,Fs,dem)

% -------------------Filtering out High Frequncies------------------%

%fir1   FIR filter design using the window method.
%Forms a 25'th order lowpass FIR digital filter
%and returns the filter coefficients in length 25+1 vector.
%The cut-off frequency Wn = fc/(Fs/2). The filter 'a' is real and
% has linear phase.
a = fir1(25,fc/(Fs/2)); %filter of order 25 and wn = fc/(Fs/2)
b = 1; % parameter b

%filters the data in demodulated signal vector with the filter
%described by vectors a and b to create the filtered and recovered data 
rec= filtfilt(a,b,dem); %final recovered signal
    
end