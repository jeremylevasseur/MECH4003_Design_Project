function [sigma] = find_gear_bend_stress(P,omega,Wdot,r_gear)
%find_gear_bend_stress finds the bending stress in the gear teeth in a
%gearbox
% input angular velocity and output angular velocity are taken in along
% with power transmitted by the gearbox. The pitch
% will be stepped through in order to find optimal pitch and # of gears
% which allow for infinite life
Vg=find_gear_velocity(r_gear,omega);
Ft=33000*Wdot/Vg; %force at gear interface, in lbs


b=find_gear_width(P);
J=0.8; %just kinda of guessed er and didn't actually calc # of teeth
Kv=(78+sqrt(Vg))/78;
Ko=1;% from table 15.1, assuming uniform power and shock
if 0<=b<=2
    Km=1.3;
elseif 2<b<=6
    Km=1.3;
elseif 6<b<=9
    Km=1.4;
elseif 9<b<=16
    Km=1.5;
else
    Km=1.8;
end

sigma=(Ft*P*Kv*Ko*0.93*Km)/(b*J) %bending stress calculation, in psi

end

