function [coefFric] = lookupCoefficientFriction(S,lengthRatio,clearanceRatio)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

x=[0;0.01;0.04;0.1;0.4;1;4;10];
a=[0;0.9;2.2;5;12;26;90;200];%0.25
b=[0;0.8;1.8;3.6;10;25;75;200];%0.5
c=[0;0.8;1.5;2.8;9;24;75;200];%1
d=[0;0.6;1.2;2;7.5;24;75;200];%infintite

coefFric = 7/clearanceRatio;
%coefFric = interpolateCharts(S,lengthRatio,x,a,b,c,d)/clearanceRatio;

end

