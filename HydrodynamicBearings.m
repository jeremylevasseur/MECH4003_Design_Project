R=0.15;%metres
P=1.5e6;%Pascals
maxEccent=0.001;%maximum eccentricity 10cm

shaft = "pinion";
bearing = "left";

if(shaft=="gear")
    RPM = 6000;
elseif(shaft=="pinion")
    RPM=3600;
else
    error("AIDS");
end


% add variable for gearclearance to bearings
% add left/right gear/pinion switches
[X Y] = BearingForceEquillibrium(6.2,12.4,6.2,6.2,1,16048,1205,0,[94965 94965 0],[0,0,0]);

if(bearing=="left")
    vec = X;
elseif(bearing =="right")
    vec=Y;
else
    error("AIDS");
end

W=norm(vec);



mew = 7e-6;%ISO VG7
cp=1220;

ititialOilTemp=40;
oilTemp=100;
while(oilTemp>93)
    R
    L=W/(2*R*P);
    c=0.0001;
    p=0;
    while(p==0)
        S=getBearingCharacteristic(R,c,mew,RPM,P);
        h0=lookupMinFilmThickness(S,L/(2*R),c);
        if(h0<getMinH0(2*R))
            c=c*0.9;
            continue
        else
            p=1;
        end
    end
    if(c-h0>maxEccent)
        R=R*1.1
        continue
    end
    f=lookupCoefficientFriction(S,L/(R*2),R/c);
    Q=lookupFlowRate(S,L/(2*R),R,c,RPM);
    oilTemp = ititialOilTemp+oilTempRise(frictionTorque(W,R*2,f),Q,cp);
    if(oilTemp>93)
        R=R*1.1;
    end
end
R
L
c
h0
f
Q
oilTemp

