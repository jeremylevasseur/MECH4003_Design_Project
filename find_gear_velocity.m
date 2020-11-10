function [Vg] = find_gear_velocity(r_pinion,omega_in)
%find_gear_velocity calculates the pitchline velocity of a gear given its
%radius and angular velocity.

Vg=2*pi*(1/12)*r_pinion*omega_in; %velocity in ft/min

end

