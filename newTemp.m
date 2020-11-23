function [newTemp] = newTemp(SAEOilNum,oldTemp,initialOilTemp,R,c,RPM,P,L,radialLoad)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
cp=1220;
mew=oilViscosity(SAEOilNum,0.5*(initialOilTemp+oldTemp));
S=getBearingCharacteristic(R,c,mew,RPM,P);
f=lookupCoefficientFriction(S,L/(R*2),R/c);
Q=lookupFlowRate(S,L/(2*R),R,c,RPM);
newTemp = initialOilTemp+oilTempRise(frictionTorque(radialLoad,R*2,f),Q,cp);
end

