function [deltaT] = oilTempRise(heat,Q,specificHeat)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

deltaT = heat/(Q*specificHeat);

end

