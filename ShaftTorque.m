function[Torque] = ShaftTorque(Power,RPM,SF)
%SHAFTTORQUE finds the torque in a given shaft
%   Inputs: Power is power in Watts
%           RPM is the rotations per minute of the shaft
%           SF is the safety factor
%   Outputs:    Torque is the torque applied to the shaft in Newton Metres

%torque calculation
Torque = (Power*SF)/(2*pi()*RPM*(1/60)); %N.m

%outputs torque
end
