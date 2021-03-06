
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
SAEnum = 40;
initialOilTemp = 30;


prob=optimproblem('ObjectiveSense','min')
R=optimvar('R','LowerBound',shaftDiam/2,'UpperBound',gearRad/2)
c=optimvar('c',1,'LowerBound',0)
L=optimvar('L',1,'LowerBound',0)
%prob.Objective = L*pi()*R^2*0.00739*42.52; minimize raw material costs
prob.Objective =RPM*2*pi()*1/60*frictionTorque(getUnitLoad(W,2*R,L),2*R,lookupCoefficientFriction(getBearingCharacteristic(R,c,oilViscosity(SAEnum,initialOilTemp),RPM,getUnitLoad(W,2*R,L)),L/R,R/c));
cons1 = shitsFuckedBrotha(W,R,L,c,40,RPM) <=91;
cons2 = lookupMinFilmThickness(getBearingCharacteristic(R,c,oilViscosity(SAEnum,initialOilTemp),RPM,getUnitLoad(W,2*R,L)),0.5*L/R,c) >=getMinH0(2*R)
cons3 = c-lookupMinFilmThickness(getBearingCharacteristic(R,c,oilViscosity(SAEnum,initialOilTemp),RPM,getUnitLoad(W,2*R,L)),0.5*L/R,c) <=maxEccent
cons4 = lookupMinFilmThickness(getBearingCharacteristic(R,c,oilViscosity(SAEnum,initialOilTemp),RPM,getUnitLoad(W,2*R,L)),0.5*L/R,c) <= c;
cons5 = getUnitLoad(W,2*R,L) <=1.5e6;
cons6 = c>=0.001*0.0254;%greater than 1 thou for tolerance
prob.Constraints.cons1 = cons1;
prob.Constraints.cons2 = cons2;
prob.Constraints.cons3 = cons3;
prob.Constraints.cons4 = cons4;
prob.Constraints.cons5 = cons5;
prob.Constraints.cons6 = cons6;
initial.R = 0.15;
initial.L = 0.1;
initial.c = 0.001;
% problem = prob2struct(prob,initial,'ObjectiveFunctionName','rosenbrock','ConstraintFunctionName','circle2');
% fmincon(problem)
sol = solve(prob,initial)
bestR = sol.R
bestL = sol.L
bestc = sol.c
powerLoss = RPM*2*pi()*1/60*frictionTorque(getUnitLoad(W,2*bestR,bestL),2*bestR,lookupCoefficientFriction(getBearingCharacteristic(R,c,oilViscosity(SAEnum,initialOilTemp),RPM,getUnitLoad(W,2*bestR,bestL)),bestL/bestR,bestR/bestc))

% fun =@(x) RPM*2*pi()*1/60*frictionTorque(getUnitLoad(W,2*x(1),x(2)),2*x(1),lookupCoefficientFriction(getBearingCharacteristic(x(1),x(3),mew,RPM,getUnitLoad(W,2*x(1),x(2))),x(2)/x(1),x(1)/x(3)))
% initial = [0.15,0.1,0.001]
% A=[]
% b[]

%thrust
if(abs(vec(1))>0)
    disp("thrust")
    thrustProb=optimproblem('ObjectiveSense','min')
    R1=optimvar('R','LowerBound',bestR+bestc)
    Lt=optimvar('L','LowerBound',0)
    d0=optimvar('d0','LowerBound',0)
    h2=optimvar('h2','LowerBound',0.001*0.0254)
    
end
