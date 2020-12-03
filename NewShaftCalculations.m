%---------------------------------GIVENS---------------------------------%
%FORCES ACTING ON BOTH GEARS
AxialForce_imp = 50911.02; %[lb]
AxialForce = AxialForce_imp * 4.448; %[N]
RadialForce_imp = 50911.02; %[lb]
RadialForce = RadialForce_imp * 4.448; %[N]
TangentialForce_imp = 54178.37; %[lb]
TangentialForce = TangentialForce_imp * 4.448; %[N]

%KNOWN SHAFT INFORMATION
Power = 100000000; %[W]
SF = 3; %safety factor
RPM_input = 6000; %[RPM]
RPM_output = 3600; %[RPM]
Length = 2.4668; %[m]

%KNOWN GEAR INFORMATION
GearMass_input = 8.568e+03; %[kg]
GearMass_output = 2.405e+04; %[kg]

%MATERIAL INFORMATION
YieldStress_imp = 143000; %[psi]
YieldStress = YieldStress_imp * 6895; %[Pa]
UltimateStress_imp = 179000; %[psi]
UltimateStress = UltimateStress_imp * 6895; %[Pa]
Kf_bending = 1.79; %assuming semicircular end, from Peterson's
Kf_torsion = 3.4; %assuming semicircular end, from Peterson's
Kf_axial = 2; %concentration factor taken from machined steel

%------------------------------CALCULATIONS------------------------------%
%FORCE ANALYSIS - HORIZONTAL 
%It is assumed that the gear is placed at the middle of the shaft and the
%supports are from the bearings.
TangentialBearingForce = TangentialForce/2; %each bearing takes half of the load [N]
AxialBearingForce = AxialForce/2; %each bearing takes half of the load [N]

%Since the tangential bearing force is equivalent for both shafts, the
%horizontal moment will be equivalent as well.
HorizontalMoment = TangentialBearingForce * (Length/2); %[N.m]

%FORCE ANALYSIS - VERTICAL
%The weight of the gear is not negligible and must be calculated. They will
%be different for each shaft due to size differences.
GearWeight_input = GearMass_input * 9.81; %F=ma [N]
GearWeight_output = GearMass_output * 9.81; %F=ma [N]

%The radial force is a combination of the force from the motion of the
%gears and the weight. This means that the values will differ for each
%shaft. The axial force is consistent for horizontal and vertical.
RadialBearingForce_input = (RadialForce + GearWeight_input)/2; %[N]
RadialBearingForce_output = (RadialForce + GearWeight_output)/2; %[N]

VerticalMoment_input = RadialBearingForce_input * (Length/2); %[N.m]
VerticalMoment_output = RadialBearingForce_output * (Length/2); %[N.m]

%TOTAL MOMENT ANALYSIS
%The total moment for the input and outputs shafts can be found with
%Pythagorean's Theorem.
BendingMoment_input = sqrt((HorizontalMoment^2 + VerticalMoment_input^2)); %[N.m]
BendingMoment_output = sqrt((HorizontalMoment^2 + VerticalMoment_output^2)); %[N.m]

%STRESS CALCULATIONS 
%Since diameter is not known, all calculations are factors divided by d^3, 
%except axial stress which is divided by d^2.

%The torque must be determined prior to the calculation of the mean shear
%stress.
Torque_input = Power*SF/(2*pi()*RPM_input*(1/60)); %[N.m]
Torque_output = Power*SF/(2*pi()*RPM_output*(1/60)); %[N.m]

MeanShearStress_input = (16*Torque_input*Kf_torsion)/(pi()); %[N.m]
MeanShearStress_output = (16*Torque_output*Kf_torsion)/(pi()); %[N.m]

%Axial mean stress is considered negative due to the direction of the axial
%force. It is the same for both input and output.
AxialMeanStress = -(4*AxialBearingForce*Kf_axial)/pi(); %[N]

%Bending alternating stress is found using the total moment from the
%previous section.
BendingAltStress_input = (32*BendingMoment_input*Kf_bending)/pi(); %[N.m]
BendingAltStress_output = (32*BendingMoment_output*Kf_bending)/pi(); %[N.m]

%It is assumed that the alternating shear stress is equal to zero. The
%equivalent alternating stress is thus equal to the bending alternating
%stress.
AlternatingStress_input = BendingAltStress_input; %[N.m]
AlternatingStress_output = BendingAltStress_output; %[N.m]

%The equivalent mean bending stress can be calculated using a Mohr circle
%or the following equation incorporating both mean shear stress and axial
%mean stress.
MeanStress_input = (AxialMeanStress/2) + sqrt((MeanShearStress_input)^2 + ((AxialMeanStress/2)^2)); %[N.m]
MeanStress_output = (AxialMeanStress/2) + sqrt((MeanShearStress_output)^2 + ((AxialMeanStress/2)^2)); %[N.m]

%DIAMETER CALCULATIONS
%The slope of the the load line is the alternating stress divided by the
%mean stress.

Slope_input = AlternatingStress_input/MeanStress_input;
Slope_output = AlternatingStress_output/MeanStress_output;

%Endurance limit must be calculated before plotting the slopes.
Sn_prime = UltimateStress/2; 
CL = 1; %load factor
CG = 1; %gradient factor
CS = 0.6; %surface factor

EnduranceLimit = Sn_prime*CL*CG*CS; 

%Now the intercept between the load line and the endurance limit line can
%be determined.
Slope2 = (0-EnduranceLimit)/(UltimateStress-0);

xIntersect_input = (EnduranceLimit-0)/(Slope_input-Slope2);
yIntersect_input = Slope_input * xIntersect_input;
xIntersect_output = (EnduranceLimit-0)/(Slope_output-Slope2);
yIntersect_output = Slope_output * xIntersect_output;

%Using the result of the alternating stress and the outputs of the
%intersects, the diameter can be calculated.
Diameter_input = (AlternatingStress_input/yIntersect_input)^(1/3) %[m]
Diameter_output = (AlternatingStress_output/yIntersect_output)^(1/3) %[m]

%The key will be of square cross-section, with a side length equal to a
%quarter of the diameter of the shaft and a length of approximately 1.8 
%times the diameter. The hub widths are commonly between 1.5 and 2 times 
%the diameter.
KeySideLength_input = Diameter_input/4 %[m]
KeySideLength_output = Diameter_output/4 %[m]
KeyLength_input = Diameter_input * 1.8 %[m]
KeyLength_output = Diameter_output * 1.8 %[m]

%Calculations are done to ensure that the previously calculated torque does
%not exceed the yields for the shaft and keys
ShaftYield_input = ((pi()*(Diameter_input^3))/16)*(0.58*YieldStress); %[N.m]
ShaftYield_output = ((pi()*(Diameter_output^3))/16)*(0.58*YieldStress); %[N.m]
KeyYield_input = (0.58*YieldStress*KeyLength_input*(Diameter_input^2))/8; %[N.m]
KeyYield_output = (0.58*YieldStress*KeyLength_output*(Diameter_output^2))/8; %[N.m]
