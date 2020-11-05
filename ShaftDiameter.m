function[Diameter] = ShaftDiameter(Torque,Stress)
%SHAFTDIAMETER finds the diameter of a given shaft
%   Inputs: Torque is torque applied to the shaft in Newton Metres
%           Stress is the shear stress applied to the shaft in Pascals
%   Outputs:    Diameter is the diameter of the shaft in Metres

%diameter calculation
Diameter = ((Torque*16)/(Stress*pi()))^(1/3); %metres

%outputs diameter
end
