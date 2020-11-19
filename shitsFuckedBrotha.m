function [oilTemp] = shitsFuckedBrotha(W,R,L,c,initialOilTemp,RPM)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
cp=1220;
P=getUnitLoad(W,2*R,L);
mew=oilViscosity(40,initialOilTemp);
S=getBearingCharacteristic(R,c,mew,RPM,P)
f=lookupCoefficientFriction(S,L/(R*2),R/c)
Q=lookupFlowRate(S,L/(2*R),R,c,RPM);
oilTemp = initialOilTemp+oilTempRise(frictionTorque(W,R*2,f),Q,cp);

end

