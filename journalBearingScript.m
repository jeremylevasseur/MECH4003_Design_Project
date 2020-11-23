shaft = "pinion";
bearing = "right";

if(shaft=="gear")
    RPM = 6000;
    gearRad = 26*0.0254*3600/6000;
    gearWeight = gearRad^2*pi()*31*0.254;
    shaftDiam = 0.2464;
elseif(shaft=="pinion")
    RPM=3600;
    gearRad = 26*0.0254;
    gearWeight = gearRad^2*pi()*31*0.254;
    shaftDiam = 0.2754;
else
    error("AIDS");
end


% add variable for gearclearance to bearings
% add left/right gear/pinion switches
[X Y] = BearingForceEquillibrium(31*0.0254+0.3,31*0.0254+0.3*2,31*0.0254+0.3,31*0.0254+0.3,1,gearWeight,1205,0,[50911*0.04536*9.81 50911*0.04536*9.81 0],[0,50911*0.04536*9.81*gearRad,0])

if(bearing=="left")
    vec = X;
elseif(bearing =="right")
    vec=Y;
else
    error("AIDS");
end

W=norm(vec(1:2));
maxEccent = 0.01;
SAEnum = 70;%10to70

bearings = designJournalBearing(shaftDiam/2,W,SAEnum,maxEccent,RPM,20);
[Pow bearingIndex] = min(bearings(1:length(bearings),6));
bearings(bearingIndex,:)