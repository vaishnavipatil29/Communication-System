% This function generates a carrier signal
% Output: c(t) - carrier signal
function [c,fc,Fs,Ac,t] = carrier()

    %--------Parameters----------%
    Fs = 1.e4   %Sampling frequency
    Ts = 1/Fs   %time steps
    t = -0.04:Ts:0.04;  %time from -0.04 to 0.04 in ts steps
    fc = 400;       % carrier frequency
    %------Generating Sampling Frequency-----%
    Ac = 1;
    c = Ac*cos(2*pi*fc*t); % Carrier signal
    
end