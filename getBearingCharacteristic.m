function [S] = getBearingCharacteristic(R,c,mew,n,P)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

S=(R/c)^2 * mew*n/(P*60);

end

