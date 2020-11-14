function [torque] = frictionTorque(load,D,fricCoef)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

torque = load*D*fricCoef/2;

end

