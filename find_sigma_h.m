function [ sigma_h ] = find_sigma_h( P,r_gear,CR,Ft,psi,b,Kv,Ko,Km,I)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%paramaters for surface fatigue

Cp=2300; %from table 15.4, (Psi)^1/2

%Pn=P*cos(psi); %calculating pitch in plane norma to teeth to find addendum length
%a=1/Pn %addendum length
%above equations are not yielding a value of a which gives proper CR (1-2)
N=find_num_teeth(P,r_gear);
a=((N+2)/(2*P))-r_gear;
dp=2*r_gear;
sigma_h=Cp*(((Ft*a*cosd(psi)*b*Kv*Ko*0.93*Km)/(b*dp*I*0.95*CR))^(1/2)); %surface fatigue stress


end

