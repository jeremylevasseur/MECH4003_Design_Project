function [CR] = find_CR( r_pinion,gear_ratio,P,phi,I,Np)
%find_CR calculates the contact ration of meshed gears.
%   The function take in the radius of the pinion, the gear ratio, the
%   pitch, and the pressure angle


ra1=(Np+2)/(2*P); %calculating addedndum radius for the pinion [in]
rd1=(Np-2.5)/(2*P); %calculating dedendum radius for the pinion [in]
ra2=(((gear_ratio)*Np)+2)/(2*P); %calculating addedndum radius for the gear [in]
rd2=(((gear_ratio)*Np)-2.5)/(2*P); %calculating dedendum radius for the gear [in]
c=r_pinion+(gear_ratio)*r_pinion; %distance between centre of meshed gears [in]
db=2*rd1; %base diamter of pinion [in]
CR=((sqrt(ra1^2-rd1^2))+(sqrt(ra2^2-rd2^2))-(c*sind(phi)))/((3.14159*db)/(Np)); %contact ratio


end

