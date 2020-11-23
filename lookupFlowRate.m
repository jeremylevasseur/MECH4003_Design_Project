function [Q] = lookupFlowRate(S,lengthRatio,radius,clearance,RPM)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

x=[0.01;0.04;0.1;0.4;1;4;10];
a=[6.1;6.0;6.0;5.4;5.0;4.1;3.6];
b=[5.8;5.6;5.4;4.8;4.1;3.4;3.3];
c=[4.8;4.6;4.4;3.7;3.4;3.2;3.2];
d=[0.4;1.6;2.7;3.1;3.2;3.2;3.2];

% Q = 4*(radius^2)*clearance*RPM/60*lengthRatio*2;
Q = interpolateCharts(S,lengthRatio,x,a,b,c,d)*(radius^2)*clearance*RPM/60*lengthRatio*2;

if(Q<=0)
    Q=0;
end

end

