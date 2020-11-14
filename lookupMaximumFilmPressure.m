function [pMax] = lookupMaximumFilmPressure(S,lengthRatio,P)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

x=[0;0.01;0.04;0.1;0.4;1;4;10];
d=[0;0.34;0.68;0.82;0.84;0.84;0.85;0.85];
c=[0;0.21;0.32;0.40;0.51;0.55;0.56;0.57];
b=[0;0.15;0.22;0.27;0.40;0.47;0.54;0.55];
a=[0;0.10;0.15;0.19;0.27;0.33;0.45;0.52];

pmax = P/interpolateCharts(S,lengthRatio,x,a,b,c,d);

end

