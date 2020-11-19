function [P] = thrustUnitLoad(W,pads,L,R1,beta)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

R2= R1+L;
P=360*W/(pads*beta*L*pi()*(R1+R2));

end

