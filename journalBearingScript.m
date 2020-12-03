shaft = "input";
bearing = "right";
SFrad=1;
SFthrust=0.75;

width=30*0.0254;
F=309882;
F=F*SFrad;
if(shaft=="input")
    RPM = 6000;
    gearRad = 19*0.0254;
    gearWeight = gearRad^2*pi()*width*7850*9.81;
    shaftDiam = 0.3723;
     b=[F;
    -1*F*gearRad+0.681*F;
    gearWeight*0.681;
    gearWeight;
    F;
    0];
elseif(shaft=="output")
    RPM=3600;
    gearRad = 31.67*0.0254;
    gearWeight = gearRad^2*pi()*width*7850*9.81;
    shaftDiam = 0.4420;
    b=[-1*F;
    -1*F*gearRad-0.681*F;
    gearWeight*0.681;
    gearWeight;
    0;
    -1*F];
else
    error("AIDS");
end


% add variable for gearclearance to bearings
%[X Y] = BearingForceEquillibrium(31*0.0254+0.3,31*0.0254+0.3*2,31*0.0254+0.3,31*0.0254+0.3,1,gearWeight,1205,0,[50911*0.04536*9.81 50911*0.04536*9.81 0],[0,50911*0.04536*9.81*gearRad,0])

A=[1, 1, 0, 0, 0, 0;
    0, 1.362, 0, 0, 0, 0;
    0, 0, 0, 1.362, 0, 0;
    0, 0, 1, 1, 0, 0;
    0, 0, 0, 0, 1, 0;
    0, 0, 0, 0, 0, 1];

[X,R]=linsolve(A,b);


if(bearing=="left")
    vec = [X(5)*SFthrust;X(1);X(3)];
elseif(bearing =="right")
    vec=[X(6)*SFthrust;X(2);X(4)];
else
    error("AIDS");
end

W=norm(vec(2:3));
maxEccent = 0.01;
SAEnum = 70;%10to70

bearings = designJournalBearing(shaftDiam/2,W,SAEnum,maxEccent,RPM,20);
[height length] = size(bearings);
[Pow bearingIndex] = min(bearings(1:height,6));


if(vec(1)==0)    
else
    thrustBearings = thrustBearingDeisgn(bearings(bearingIndex,1)+bearings(bearingIndex,3),abs(vec(1)),RPM,SAEnum,bearings(bearingIndex,5),ThrustBearingData);
end
[height length] = size(thrustBearings);
[Pow thrustIndex] = min(thrustBearings(1:height,11));

t = table();
t=array2table(bearings(bearingIndex,:));
t.Properties.VariableNames = ["R","L","C","unitLoadKilo","oilTemp","PowerLossMega","minH","minH0","S"];
t
t2 = table();
t2=array2table(thrustBearings(thrustIndex,:));
t2.Properties.VariableNames = ["L","R1","B","x","beta","d0","h2","P","S","Q","HlossMega"];
t2