% This function convert text into binary and return two variable
% One in vector -binV other in string binS
% Input: 
%    text - Class char/string e.g text = 'Hello World'
% Output:
%    binV - Binary vector of class double
%    binS - Binary Strin  of class char/string

function [binV, binS] = text2bin(text)
%% Code
binS = dec2bin(text,8);
binS = binS';
binS = binS(:)';
binV = binS-48;
end