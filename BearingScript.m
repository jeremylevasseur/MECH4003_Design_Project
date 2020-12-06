%set which bearing to solve for
shaft = "output";
bearing = "right";

%set the safety factors to use 
SFrad=2;
SFthrust=2;
%set the maximum eccentriciy of the shaft
maxEccent = 0.01;

%select the oil to use, in SAE rating
SAEnum = 70;%10to70

%all the gear parameters
width=30*0.0254;%gear width, in metres
F=309882;%gear force = axial force = radial force, in Newtons

%all the shaft specific parameters
if(shaft=="input")
    RPM = 6000;
    gearRad = 19*0.0254;
    %assume gear is pure steel, calculat weight in N
    gearWeight = gearRad^2*pi()*width*7850*9.81;
    %The minimum shaft diameter, as determined from shaft calcs, in metres
    shaftDiam = 0.3723;
    %setup vector to solve for bearing forces
     b=[F;
    -1*F*gearRad+0.681*F;
    gearWeight*0.681;
    gearWeight;
    F;
    0];
elseif(shaft=="output")
    RPM=3600;
    gearRad = 31.67*0.0254;
    %assume gear is pure steel, calculat weight in N
    gearWeight = gearRad^2*pi()*width*7850*9.81;
    %The minimum shaft diameter, as determined from shaft calcs, in metres
    shaftDiam = 0.4420;
    %setup vector to solve for bearing forces
    b=[-1*F;
    -1*F*gearRad-0.681*F;
    gearWeight*0.681;
    gearWeight;
    0;
    -1*F];
else
    error("shaft DNE");
end

%vectors for bearing load solution
%see FBD!!
A=[1, 1, 0, 0, 0, 0;
    0, 1.362, 0, 0, 0, 0;
    0, 0, 0, 1.362, 0, 0;
    0, 0, 1, 1, 0, 0;
    0, 0, 0, 0, 1, 0;
    0, 0, 0, 0, 0, 1];
%solve for bearing loads (both left and right)
[X,R]=linsolve(A,b);

%isolate forces of bearing of interest.
%apply safety factors
if(bearing=="left")
    vec = [X(5)*SFthrust;X(1)*SFrad;X(3)*SFrad]
elseif(bearing =="right")
    vec=[X(6)*SFthrust;X(2)*SFrad;X(4)*SFrad]
else
    error("bearing DNE");
end

%combine vertical and horizontal loads into radial load
W=norm(vec(2:3))

%call journal bearing script. 
%will return all the possible bearings that meet requirements
bearings = designJournalBearing(shaftDiam/2,W,SAEnum,maxEccent,RPM,20);
[height length] = size(bearings);

%select the bearing with the lowest power loss
[Pow bearingIndex] = min(bearings(1:height,6));

%if the bearing has a thrust component, solve for the thrust bearing
if(vec(1)==0)    
else
    %call thrust bearing script, with ID as the diameter of the journal
    %bearing
    %will return all bearings that meet specs
    thrustBearings = thrustBearingDeisgn(bearings(bearingIndex,1)+bearings(bearingIndex,3),abs(vec(1)),RPM,SAEnum,bearings(bearingIndex,5),ThrustBearingData);
end
[height length] = size(thrustBearings);

%select the thrust bearing that results in the lowest power loss
[Pow thrustIndex] = min(thrustBearings(1:height,11));

%output bearing data in formatted table
t = table();
t=array2table(bearings(bearingIndex,:));
t.Properties.VariableNames = ["R","L","C","unitLoadKilo","oilTemp","PowerLossMega","minH","minH0","S"];
t
t2 = table();
t2=array2table(thrustBearings(thrustIndex,:));
t2.Properties.VariableNames = ["L","R1","B","x","beta","d0","h2","P","S","Q","HlossMega"];
t2