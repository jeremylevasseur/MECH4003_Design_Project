function [heatPower] = BearingHeat(frictionTorque,RPM)
    %BEARINGHEAT Summary of this function goes here
    %   Detailed explanation goes here

    heatPower = frictionTorque*RPM*2*pi/60;

end

