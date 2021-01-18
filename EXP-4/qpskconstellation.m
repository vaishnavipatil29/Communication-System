% This function returns a randomly generated QPSK constellation with gray labelling 
% and without gray labelling 
% Inputs: x - The input signal to be sent 
% Output: gray : constellation with gray labelling
% Output: wogray : constellation without gray labelling
function [gray wogray]= qpskconstellation(x)

%-------------------------QPSK-----------------------------------%
%have a difference of more than one bit between successive symbols.
M = 4; %Number of symbols
bits = log2(M); % Number of bits in one symbol

%-------------------------Gray labelling-------------------------%
%QPSK constellation has four bits mapped to different phases +-pi/4,+-3pi/4
%initialise gray as empty array for storing gray labelling constellation
gray = [];  %gray labelling constellation
%Gray labelling is an ordering of symbols where there is a one bit
%difference between successive symbols while other labellings can

%Consider bits = 2 in one symbol and Assign normalised symbols
%with magnitude 1/sqrt(2) and phases +-pi/4,+-3pi/4
%cosd and sind represent cosine of angle expressed in degrees
for i=1:bits:length(x)
    %if the symbol is 00 : phase is 45 degree 
    if x(i)==0 && x(i+1)==0
        y=cosd(45)+1j*sind(45); 
    %if the symbol is 01 : phase is 135 degree 
    elseif x(i)==0 && x(i+1)==1
        y=cosd(135)+1j*sind(135);
    %if the bits are 11 : phase is 225 degree 
    elseif x(i)==1 && x(i+1)==1
        y=cosd(225)+1j*sind(225);
    %if the bits are 10 : phase is 315 degree 
    elseif x(i)==1 && x(i+1)==0
        y=cosd(315)+1j*sind(315);
    end
gray=[gray y];
end

%---------------------Without Gray Labelling-------------------------%
wogray = [];  %without gray labelling constellation

%Consider bits = 2 in one symbol and Assign normalised symbols
%with magnitude 1/sqrt(2) and phases +-pi/4,+-3pi/4
%cosd and sind represent cosine of angle expressed in degrees
for i=1:bits:length(x)
    %if the symbol is 00 : phase is 45 degree 
    if x(i)==0 && x(i+1)==0
        y=cosd(45)+1j*sind(45); 
    %if the symbol is 01 : phase is 135 degree 
    elseif x(i)==0 && x(i+1)==1
        y=cosd(135)+1j*sind(135);
    %if the bits are 10 : phase is 225 degree 
    elseif x(i)==1 && x(i+1)==0
        y=cosd(225)+1j*sind(225);
    %if the bits are 11 : phase is 315 degree 
    elseif x(i)==1 && x(i+1)==1
        y=cosd(315)+1j*sind(315);
    end
wogray=[wogray y];
end

end