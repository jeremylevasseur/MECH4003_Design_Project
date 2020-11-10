function [ sigma_h ] = find_sigma_h( P,r_gear,CR,Ft,psi,b,Kv,Ko,Km,I)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%paramaters for surface fatigue

%Cp=2300; %from table 15.4, (Psi)^1/2
Cp=0.564*sqrt((1)/(2*((1-(0.33^2))/(29000000))));

N=find_num_teeth(P,r_gear);
dp=2*r_gear;
sigma_h=Cp*(((Ft*cosd(psi)*Kv*Ko*0.93*Km)/(b*dp*I*0.95*CR))^(1/2)); %surface fatigue stress


end