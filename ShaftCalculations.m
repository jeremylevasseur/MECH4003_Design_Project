%T is input, G is output

P = 100000000; %Watts
RPM_T = 6000;
RPM_G = 3600;
SF = 1.5;
Stress_imp = 162000; %psi
Stress = Stress_imp * 6895; %Pa

Torque_T = P*SF/(2*pi()*RPM_T*(1/60)) %N.m
Torque_G = P*SF/(2*pi()*RPM_G*(1/60)) %N.m

Length = (38/39.37) + 2*(2/39.37) + 1 %arbitrarily increased by 1000 mm

GearMass_T = 8.568e+06; %kilograms
GearMass_G = 2.405e+07; %kilograms

GearForce_T = GearMass_T * 9.81; %calculating the force of the gears to find the bending moment
GearForce_G = GearMass_G * 9.81; %calculating the force of the gears to find the bending moment

Moment_T = (GearForce_T*Length)/4; %with the assumption that the gear is placed at the midpoint of the shaft
Moment_G = (GearForce_G*Length)/4; %with the assumption that the gear is placed at the midpoint of the shaft

Diameter_T = ((5.1/Stress)*((Torque_T^2 + Moment_T^2)^(1/2)))^(1/3) %metres
Diameter_G = ((5.1/Stress)*((Torque_G^2 + Moment_G^2)^(1/2)))^(1/3) %metres

