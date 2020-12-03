function [bearings] = designJournalBearing(shaftRadius,radialLoad,SAEOilNum,maxEccent,RPM,initialOilTemp)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
cp=1220;
bearings =[];
radialLoad = radialLoad;

for R=shaftRadius:0.05:3*shaftRadius
    for L=R:0.1:1.5
        P = getUnitLoad(radialLoad,2*R,L);
        if(P>1.5e6)
            continue;
        end
        minC = max(getMinH0(2*R)+maxEccent, 0.001*0.0254);
        i=0;
        for c=minC:0.05:0.25*R
            fun = @(oldTemp) newTemp(SAEOilNum,oldTemp,initialOilTemp,R,c,RPM,P,L,radialLoad) - oldTemp;
            oilTemp = fzero(fun,[initialOilTemp*0.99,150]);
            mew=oilViscosity(SAEOilNum,0.5*(initialOilTemp+oilTemp));
            S=getBearingCharacteristic(R,c,mew,RPM,P);
            f=lookupCoefficientFriction(S,L/(R*2),R/c);
            Q=lookupFlowRate(S,L/(2*R),R,c,RPM);
            i=i+1;
            disp("s "+S+" l "+L+" R "+R+" c "+c+" T "+oilTemp);
            if(oilTemp>91 || oilTemp<0 || f==0 || Q==0)
                continue;
            else
                minH = lookupMinFilmThickness(S,L/(2*R),c);
                if(minH>getMinH0(2*R) && minH<c)
                    powerLoss = RPM*2*pi()*1/60*frictionTorque(P,2*R,lookupCoefficientFriction(S,L/R,R/c));
                    powerLoss = powerLoss *1e-6;
                    bearing = [R,L,c,P*1e-3,oilTemp,powerLoss,minH,getMinH0(2*R),S];
                    bearings = [bearings; bearing];
                end
            end
        end
    end
end


end

