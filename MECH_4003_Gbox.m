%Script to keep track of all assumptions and constants used for gear
%calculations
%initial choice of material 9310 ALLOY STEEL
%Choice is somewhat arbitraty but 9310 is good gear material

%defined project paramters
omega_in=6000 %in RPM
omega_out=3600 %in RPM
Wdot=100000000 %in MW

%prompt for gear radius and assume single reduction
prompt= 'Enter input gear radius'
rg1=input(prompt);
rg2=rg1/1.67;
psi=20;
phi=20;

%below are defined parameters for the endurance limit
Su= 1289320000; %tensile strength
SprimeN= 0.5*Su;
CL=1; %bending load
Cg=1; % for P>5 but 0.85 for P<=5
Cs=0.85; %for specific material assuming finely ground figure 8.13
Kr=0.814;%table 15.3 assuming 99% reliability
Kt=1; %if lubrication temp is less than 160F
Kms= 1.4; %for input output gears and =1 for intermediate gears

Sn=SprimeN*CL*Cg*Cs*Kr*Kt*Kms %infinite life endurance limit

%below are defined paremters for bending stress
Vg=2*3.1415*(1/60)*rg1*omega_in; %velocity based on radius of first gear
Ft=Wdot/Vg; %force at gear interface
P=16; %I chose arbitrary pitch******revise 
m=25.4/P ;%basically the metric pitch inn mm/tooth
N=2*rg1/(m*10^-3) %calculating N to find b, converting module to m from mm
p=(3.14159*2*rg1)/N; %calc'ing p to find b
pa=p/tan(psi);% for a helical gear
b=2*pa; %pg. 620 b>=2pa
J=0.5; %just kinda of guessed er and didn't actually calc # of gears
Kv= (78+(Vg)^1/2)/78;
Ko= 1 ;% from table 15.1, assuming uniform power and shock
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

sigma=(Ft*m*Kv*Ko*0.93*Km)/(b*J) %bending stress calculation


%paramaters for surface fatigue
Cp=191000000; %from table 15.4
Pn=P*cos(psi); %calculating pitch in plane norma to teeth to find addendum length
a=1/Pn; %addendum length
I=(sin(phi)*cos(phi)*(1/1.67))/(2*((1/1.67)+1)); %R=dg/dp which is the gear ratio
rap=rg1+a; % pitch radius plus addendum for pinion (gear 1)
rbp=rg1-(1.25*a); %base radius as stated on pg. 571
rag=rg2+a; % pitch radius plus addendum for gear (gear 2)
rbg=rg2-(1.25*a); 
dp1=2*rg1; %finding pitch diam for both gears because they will have different surface fatigue stress
dp2=2*rg2;
c=rg1+rg2; %for calculating CR
db=2*rbp; %need base dia. for CR. Not sure which value to use though. CR should be same for both.
CR=((rap^2-rbp^2)^1/2+(rag^2-rbg^2)^1/2-(c*sin(phi)))/((3.14159*db)/(N)) %contact ratio
sigma_h1=Cp*(((Ft*a*cos(psi)*b*Kv*Ko*0.93*Km)/(b*dp1*I*0.95*CR))^1/2) %surface fatigue stress
sigma_h2=Cp*(((Ft*a*cos(psi)*b*Kv*Ko*0.93*Km)/(b*dp2*I*0.95*CR))^1/2)