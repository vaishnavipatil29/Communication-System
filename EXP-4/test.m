%-------------------------QAM-----------------------------------%
M = 16; %Number of symbols
bits = log2(M); % Number of bits in one symbol
x= randi([0,1],1,1000)
%-------------------------Gray labelling-------------------------%
%16-QAM constellation has 16 symbols mapped to different phases and
%amplitudes 
%initialise gray as empty array for storing gray labelling constellation
gray = [];  %gray labelling constellation
%Gray labelling is an ordering of symbols where there is a one bit
%difference between successive symbols 
for i=1:bits:length(x)
    %if the symbol is 0010 : (-3,-3)
    if x(i)==0 && x(i+1)==0 && x(i+2)==1 && x(i+3)==0
        y=-3+1j*3; 
    elseif x(i)==0 && x(i+1)==1 && x(i+2)==1 && x(i+3)==0
        y=-1+1j*3;    
    elseif x(i)==1 && x(i+1)==1 && x(i+2)==1 && x(i+3)==0
        y= 1+1j*3;  
    elseif x(i)==1 && x(i+1)==0 && x(i+2)==1 && x(i+3)==0
        y=3+1j*3; 
    elseif x(i)==0 && x(i+1)==0 && x(i+2)==1 && x(i+3)==1
        y=-3+1j*1;
    elseif x(i)==0 && x(i+1)==1 && x(i+2)==1 && x(i+3)==1
        y=-1+1j*1;
    elseif x(i)==1 && x(i+1)==1 && x(i+2)==1 && x(i+3)==1
        y=1+1j*1;
    elseif x(i)==1 && x(i+1)==0 && x(i+2)==1 && x(i+3)==1
        y=3+1j*1;
    elseif x(i)==0 && x(i+1)==0 && x(i+2)==0 && x(i+3)==1
        y=-3+1j*-1;
    elseif x(i)==0 && x(i+1)==1 && x(i+2)==0 && x(i+3)==1
        y=-1+1j*-1;
    elseif x(i)==1 && x(i+1)==1 && x(i+2)==0 && x(i+3)==1
        y=1+1j*-1;
    elseif x(i)==1 && x(i+1)==0 && x(i+2)==0 && x(i+3)==1
        y=3+1j*-1;
    elseif x(i)==0 && x(i+1)==0 && x(i+2)==0 && x(i+3)==0
        y=-3+1j*-3;
    elseif x(i)==0 && x(i+1)==1 && x(i+2)==0 && x(i+3)==0
        y=-1+1j*-3;
    elseif x(i)==1 && x(i+1)==1 && x(i+2)==0 && x(i+3)==0
        y=1+1j*-3;
    elseif x(i)==1 && x(i+1)==0 && x(i+2)==0 && x(i+3)==0
        y=3+1j*-3;
    end
    gray=[gray y];
end
scatterplot(gray)
title('16 QAM Constellation')