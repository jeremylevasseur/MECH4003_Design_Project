function [thicknessVariable] = lookupMinFilmThickness(S,lengthRatio)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here


%input table values
x=[0;0.01;0.04;0.1;0.4;1;4;10];
a=[0;0.03;0.08;0.14;0.25;0.4;0.65;0.85];%ratio=0.25
b=[0;0.04;0.12;0.22;0.45;0.66;0.89;0.94];%ratio=0/5
c=[0;0.05;0.18;0.35;0.7;0.86;0.98;1];%ratio=1
d=[0;0.08;0.4;0.74;0.95;0.98;1;1];%ratio = infinite

% splines = [spline(x,a,S);spline(x,b,S);spline(x,c,S);spline(x,d,S)];
splines = [interp1q(x,a,S);interp1q(x,b,S);interp1q(x,c,S);interp1q(x,d,S)];

thicknessVariable = interpolateCharts(lengthRatio,splines);

X=[0.01:0.1:10];
y1=X;
y2=X;
y3=X;
y4=X;
for i=1:length(X)
    y1(i) = interp1q(x,d,X(i));
    y2(i) = interp1q(x,c,X(i));
    y3(i) = interp1q(x,b,X(i));
    y4(i) = interp1q(x,a,X(i));
end

semilogx(X,y1,X,y2,X,y3,X,y4)
end

