function [Vg] = find_gear_velocity(r_gear, omega_in)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Vg=2*pi*(1/12)*r_gear*omega_in; %velocity based on radius of first gear, I think ft/min or something stupid like that

end

