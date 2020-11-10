function[Diameter] = ShaftDiameter(GearWidth,BearingWidth,GearMass,Torque,Stress)
%SHAFTDIAMETER finds the diameter in a given shaft
%   Inputs: GearWidth is the width of the gear in Metres
%           BearingWidth is the width of the bearings in Metres
%           GearMass is the mass of the gear in kg           
%           Torque is torque applied to the shaft in Newton Metres
%           Stress is the shear stress applied to the shaft in Pascals
%   Outputs:    Diameter is the diameter of the shaft in Metres

Length = GearWidth + (2*BearingWidth) + 0.1; %arbitrarily increased by 100 mm

GearForce = GearMass * 9.81; %calculating the force of the gears to find the bending moment

Moment = (GearForce*Length)/4; %with the assumption that the gear is placed at the midpoint of the shaft

Diameter = ((5.1/Stress)*(((Torque^2 + Moment^2)^(1/2))))^(1/3); %calculating the diameter with the maximum shear stress

%outputs diameter
end
