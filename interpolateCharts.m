function [y] = interpolateCharts(x,vars)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

a=vars(1);
b=vars(2);
c=vars(3);
d=vars(4);
y=(1/(x^3))*((-1/8)*(1-x)*(1-2*x)*(1-4*x)*d+(1/3)*(1-2*x)*(1-4*x)*c-(1/4)*(1-x)*(1-4*x)*b+(1/24)*(1-x)*(1-2*x)*a);

end

