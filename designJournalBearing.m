function [bearing] = designJournalBearing(shaftRadius,radialLoad,SAEOilNum,maxEccent,RPM)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

bearings =[];

for R=shaftRadius:0.1:2*shaftRadius
    for L=0.5*R:0.1:5*R
        P = getUnitLoad(radialLoad,2*R,L;
        if(P>1.5e6)
            continue;
        end
        minC = max(getMinH0(2*R)+maxEccent, 0.001*0.0254);
        for c=minC:0.01:0.2*R
            oldTemp=0;
            newTemp=40;
            while(abs(newTemp-oldTemp)/oldTemp >0.05)
                oldTemp = newTemp;
                newTemp = shitsFuckedBrotha(radialLoad,R,L,c,oldTemp,RPM);
            end
            if(newTemp>91)
                continue;
            else
                S = getBearingCharacteristic(R,c,oilViscosity(SAEOilNum,newTemp),RPM,P);
                minH = lookupMinFilmThckness(S,L/(2*R),c);
                if(minH>getMinH0(2*R) && minH>c)
                    powerLoss = RPM*2*pi()*1/60*frictionTorque(P,2*R,lookupCoefficientFriction(S,RPM,P),L/R,R/c));
                    bearings = [bearings; R,L,c,P,newTemp,powerLoss];
                end
            end
        end
    end
end


end

