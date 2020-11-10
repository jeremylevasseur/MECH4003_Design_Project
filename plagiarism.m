% Mechanical System Design Calculation

% Calculating forces and stresses for helical gearbox
% to transfer power from a 100MW Turbine at 6000 rpm 
% to a generator with rpm 3600 rpm. All other system 
% parameters to be selected or calculated.

%Known parameters
    Power = 100*1341.02; %Turbine power in (Hp)
    w1 = 6000; %speed of input shaft (rpm)
    w2 = 3600; %speed of output shaft (rpm)

%Life span is 20 years
    yearstomin = ((16*365)+(4*366))*24*60;
    cyclesperyear = 6000*yearstomin;

%Chosen parmeters 
    N2 = 90; %# of teeth of gear 
    phi = 20; %helix angle in degrees [?]
    PHIN = 20; %Normal pressure angle in degrees [?n]

%Calculated parameters

    %Gear Geometry
    N1 = (w2/w1)*N2; %# of teeth of pinion
    PHI = atand(tand(PHIN)/cosd(phi)); %pressure angle in degrees [?]
    d1 = 60; %[in] Assumed for now.
    d2 = (N2/N1)*d1; %diameter of gear 2
    d1b = d1*cosd(PHI); %Base diameter of gear 1
    d2b = d2*cosd(PHI); %Base diameter of gear 2
    r1b = d1b/2; %Base radius of gear 1
    r2b = d2b/2; %Base radius of gear 2
    P = N1/d1; %diametral pitch
    p = pi*(d1/N1); %Circular pitch of gear 1&2
    pb = p*cosd(PHI); %base pitch of gear 1&2
    a1 = p/pi; %addendum of 1
    %a2 = p/pi; %addendum of 2
    ra1 = (d1/2) + a1; %addendum radius 1
    ra2 = (d2/2) + a1; %addendum radius 2
    c = (d1+d2)/2; %center distance
    
    
    %Velocities
    V = (pi*d1*w1)/12; %[ft/min]
    
    %Forces
    Ft = (33000*Power)/V; %[lb]
    Fr = Ft*tand(PHI); %[lb]
    Fa = Ft*tand(phi); %[lb]

%Bending and Surface Fatigue Strengths

%Knowns fom Research
% gear material name AISI 4320 (Oil quenched and tempered). 

Sy = 146000; %[psi]Yeild Strength
Su = 165000; %[psi]Ultimate Strength
 b = 20;%(2*pi*d1/N1):0.01:(10*pi*d1/N1); %[in]face width criteria 
 J = 0.59; %J-Factor from Figure 16.8, p.685
Kv = (78+(V^0.5))/78; %Dynamic factor from Figure 15.24, p.644 (high precision, shaved and ground CaseB)
Ko = 1.25; %Overload factor from Table 15.1, p.645 (moderate shock)
Km = 1.45; %Mounting factor from Table 15.2, p.645 (*b is given in inches*)
CL = 1.00; %Load factor (bending)
CG = 1.00; %Gradient factor from Table 8.1, p.645 (P>5)
CS = 0.68; %Surface factor from Figure 8.13, p.323 (machined) 

Cp = 2300; %(steel pinion and gear for now)

kr = 0.814; %Reliability factor Table 15.3, p.645 (99%)
kt = 1; %Temperature factor. Use 1 for steel gears if lubrication temp < 160°F
        %Otherwise kt=620/(460 + T)
kms= 1.4; %Mean stress factor (Use 1 for idlergears and 1.4 for input and output gears

CLi= 0.7; %Surface fatigue life factor Figure 15.27, p.653 (based on cycles per year of gear 1)
CR = 1; %Reliability factor Table 8.1, p.654 (99% reliability)
Sfe= ((0.4*610)-10)*1000; %Surface fatigue strength [psi] Table 15.5, p.653 (*steel for now!*)
ContactRatio = ((((ra1^2)-(r1b^2))^0.5)+(((ra2^2)-(r2b^2))^0.5)-(c*sind(PHI)))/pb; %Contact Ratio > 1

R = d2/d1; %Gear-pinion ratio
I = ((sind(PHI)*cosd(PHI))/2)*(R/(R+1)); %Dimentionless constant

%Calculated
SF = 1.5; %Safety Factor

sigma = ((Ft*P)./(b.*J))*Kv*Ko*(0.93*Km)*SF; %tooth bending strength
Sn = ((0.5*Su)*CL*CG*CS*kr*kt*kms); %10E07 cycles
sigmaH = Cp*(((Ft*cosd(phi)*Kv*Ko*0.93*Km)./(b.*d1*I*0.95*ContactRatio)).^0.5)*SF; %Bending Stress; 
SH = (Sfe*CLi*CR);

%Gearbox Efficiency?
%eff = (PowerO/Power)*100; 


%Aceptable Criteria Plot
    for X=1:1:length(b)
        if sigma(X)>Sn
            plot(b(X),sigma(X), 'rx','LineWidth',2,'Color','red'); 
            hold on
        else 
            plot(b(X),sigma(X), 'gx','LineWidth',2,'Color','green');
            hold on
        end

    end

    hold on
    plot(b,Sn, 'kx','LineWidth',2,'Color','black');
    xlabel('Tooth width')
    ylabel('Bending Stress')
    set(gcf,'color','w')
    hold off

    figure(2);
    plot(b,sigmaH, '-','LineWidth',2,'Color','black');
    hold on
    plot(b,SH, 'x','LineWidth',2,'Color','red');
    xlabel('Tooth width')
    ylabel('Surface Fatigue Strength')
    set(gcf,'color','w')
