function [y] = interpolateCharts(S,lengthRatio,X,A,B,C,D)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

a=interp1(X,A,S,'makima')
b=interp1(X,B,S,'makima');
c=interp1(X,C,S,'makima');
d=interp1(X,D,S,'makima');

y=(1/(lengthRatio^3))*((-1/8)*(1-lengthRatio)*(1-2*lengthRatio)*(1-4*lengthRatio)*d+(1/3)*(1-2*lengthRatio)*(1-4*lengthRatio)*c-(1/4)*(1-lengthRatio)*(1-4*lengthRatio)*b+(1/24)*(1-lengthRatio)*(1-2*lengthRatio)*a);

%y=dankChartInterpolation(S,lengthRatio,X,A,B,C,D);

end

