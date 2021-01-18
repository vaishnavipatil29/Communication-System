% This function generates a message signal 
% Output: m(t) - message signal
% m1 extends across negative values of time and 
% m2 extends across positive values of time
% m1-m2 : gives the message signal extending over both positive and
% negative time.
function m = msg()
    t1 = -0.02:1.e-4:0;
    t2 = 0:1.e-4:0.02;
    Ta = 0.01;
    
    %Generating m1 : traingualar wave for negative t
    m1 = 1-abs((t1+Ta)/Ta);
    % Append 200 and 400 zeros respectively on either side of the signal 
    % to make sure that m2 signal gets subtracted by zeros
    % when m1 does not exist
    m1 = [zeros([1 200]),m1,zeros([1 400])];
    
    %Generating m2 : traingualar wave for positive t
    m2 = 1-abs((t2-Ta)/Ta);
    % Append 400 and 200 zeros respectively on either side of the signal 
    % to make sure that m1 signal gets subtracted by zeros
    % when m2 does not exist
    m2 = [zeros([1 400]),m2,zeros([1 200])];
    
    %Final Message signal
    m=m1-m2; 
end