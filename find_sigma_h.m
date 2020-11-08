function [ sigma_h ] = find_sigma_h( P,r_gear )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%paramaters for surface fatigue

Cp=2300; %from table 15.4, (Psi)^1/2

%Pn=P*cos(psi); %calculating pitch in plane norma to teeth to find addendum length
%a=1/Pn %addendum length
%above equations are not yielding a value of a which gives proper CR (1-2)


    a
    CR


sigma_h1=Cp*(((Ft*a*cos(psi)*b*Kv*Ko*0.93*Km)/(b*dp1*I*0.95*CR))^1/2) %surface fatigue stress
sigma_h2=Cp*(((Ft*a*cos(psi)*b*Kv*Ko*0.93*Km)/(b*dp2*I*0.95*CR))^1/2)

end

