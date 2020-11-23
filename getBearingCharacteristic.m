function [S] = getBearingCharacteristic(R,c,mew,RPM,P)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

S=(R/c)^2 * mew*RPM/(P*60);

end

