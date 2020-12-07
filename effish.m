function [Eff] = effish(gear_ratio,r_pinion,P,psy,phi)
%effish finds the efficiency of a helical gear pair given the gear ratio,
%the radius of the pinion, the pitch of the gear mesh, the pressure angle
%and the helix angle

Np=find_num_teeth(P,r_pinion); %finding number of teeth on pinion
co_fric=0.1;
ra2=(((gear_ratio)*Np)+2)/(2*P); %calculating addedndum radius for the gear [in]
ra1=(Np+2)/(2*P); %calculating addedndum radius for the pinion [in]
wangle=atand(tand(phi)*tand(psy));
hangle=(cosd(wangle))/(cosd(psy))^2;
Hs=(gear_ratio+1)*(sqrt((ra1/r_pinion)^2-(cosd(phi))^2)-sind(phi));
Ht=((gear_ratio+1)/(gear_ratio))*(sqrt((ra2/(gear_ratio*r_pinion))^2-(cosd(phi))^2)-sind(phi));
P=(50*co_fric*(Hs^2+Ht^2))/(hangle*(Hs+Ht));
Eff=100-P;
end

