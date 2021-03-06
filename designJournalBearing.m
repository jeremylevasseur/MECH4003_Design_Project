function [bearings] = designJournalBearing(shaftRadius,radialLoad,SAEOilNum,maxEccent,RPM,initialOilTemp)
% shaftRadius - minimum shaft radius
% radialLoad - obvious
% SAEOilNum - the sae designation of the oil used
% maxEcccent - the maximum shaft eccentricity
% RPM - obvious
% initialOilTemp - the temperature of the oil when it enters the bearing

%oil heat capacity
cp=1220;

bearings =[];

%loop through all possible shaft radiuses
for R=shaftRadius:0.05:3*shaftRadius
    %llop through all possible bearing lengths
    for L=R:0.1:1.5
        %calcualte the unit load. Skip bearing if it is too high
        P = getUnitLoad(radialLoad,2*R,L);
        if(P>1.5e6)
            continue;
        end
        
        %calculate the minimum allowable c, depending on eccentricity or
        %manufacturing tolerance
        minC = max(getMinH0(2*R)+maxEccent, 0.001*0.0254);
        i=0;
        
        %loop through all possible values of c
        for c=minC:0.05:0.25*R
            %calulate the temperature out of the bearing by converging heat
            %generation function
            fun = @(oldTemp) newTemp(SAEOilNum,oldTemp,initialOilTemp,R,c,RPM,P,L,radialLoad) - oldTemp;
            oilTemp = fzero(fun,[initialOilTemp*0.99,150]);
            
            %calaulte the oil ciscosity and bearing characteristic
            mew=oilViscosity(SAEOilNum,0.5*(initialOilTemp+oilTemp));
            S=getBearingCharacteristic(R,c,mew,RPM,P);
            
            %lookup friction and flow rate values
            f=lookupCoefficientFriction(S,L/(R*2),R/c);
            Q=lookupFlowRate(S,L/(2*R),R,c,RPM);
            
            i=i+1;
            disp("s "+S+" l "+L+" R "+R+" c "+c+" T "+oilTemp);
            
            %if the bearing doesnt meet requirements, skip to next loop
            if(oilTemp>91 || oilTemp<0 || f==0 || Q==0)
                continue;
            else
                
                %lookup the minimum actual h0 at full load
                minH = lookupMinFilmThickness(S,L/(2*R),c);
                
                %if the actual h0 is greater than the minimum allowable, at
                %the bearing to possibl bearings list
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

%return possible bearings list
end

