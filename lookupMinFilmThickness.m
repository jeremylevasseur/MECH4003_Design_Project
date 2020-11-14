function [minThickness] = lookupMinFilmThickness(S,lengthRatio,clearance)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here


%input table values
x=[0;0.01;0.04;0.1;0.4;1;4;10];
a=[0;0.03;0.08;0.14;0.25;0.4;0.65;0.85];%ratio=0.25
b=[0;0.04;0.12;0.22;0.45;0.66;0.89;0.94];%ratio=0/5
c=[0;0.05;0.18;0.35;0.7;0.86;0.98;1];%ratio=1
d=[0;0.08;0.4;0.74;0.95;0.98;1;1];%ratio = infinite


minThickness = interpolateCharts(S,lengthRatio,x,a,b,c,d*clearance);
% 
% X=[0.01:0.1:10];
% y1=X;
% y2=X;
% y3=X;
% y4=X;
% 
% for i=1:length(X)
%     y1(i) = interp1(x,d,X(i),'makima');
%     y2(i) = interp1(x,c,X(i),'makima');
%     y3(i) = interp1(x,b,X(i),'makima');
%     y4(i) = interp1(x,a,X(i),'makima');
% end
% 
% semilogx(X,y1,X,y2,X,y3,X,y4)
end

