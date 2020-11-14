function [angle] = lookupMinThicknessAngle(S,lengthRatio)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

x=[0;0.01;0.04;0.1;0.4;1;4;10];
d=[0;34;54;66;70;70;70;70];
c=[0;24;35;48;70;80;84;85];
b=[0;17;26;34;52;66;82;87];
a=[0;13;18;25;35;46;68;80];

angle = interpolateCharts(S,lengthRatio,x,a,b,c,d);

end

