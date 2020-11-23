function [bearings] = designJournalBearing(shaftRadius,radialLoad,SAEOilNum,maxEccent,RPM,initialOilTemp)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
cp=1220;
bearings =[];
maxN = 20;
radialLoad = radialLoad/1e0;

for R=shaftRadius:0.05:2*shaftRadius
    for L=R:0.05:1
        P = getUnitLoad(radialLoad,2*R,L);
        if(P>1.5e6)
            continue;
        end
        minC = max(getMinH0(2*R)+maxEccent, 0.001*0.0254);
        i=0;
        for c=minC:0.01:0.25*R
%             oldTemp=initialOilTemp;
%             newTemp=1000;
%             n=0;
%             while(abs(newTemp-oldTemp)/abs(oldTemp) >0.05 && n<maxN)
%                 %abs(newTemp-oldTemp)/abs(oldTemp)
%                 n=n+1;
%                 oldTemp = newTemp;
% %                 mew=oilViscosity(SAEOilNum,0.5*(initialOilTemp+oldTemp));
% %                 S=getBearingCharacteristic(R,c,mew,RPM,P);
% %                 f=lookupCoefficientFriction(S,L/(R*2),R/c);
% %                 Q=lookupFlowRate(S,L/(2*R),R,c,RPM);
% %                 newTemp = initialOilTemp+oilTempRise(frictionTorque(radialLoad,R*2,f),Q,cp);
%                 
%             end
% x= [initialOilTemp/2:100]
% for m=1:length(x)
%     y(m) = newTemp(SAEOilNum,x(m),initialOilTemp,R,c,RPM,P,L,radialLoad) - x(m)
% end
% plot(x,y)
            fun = @(oldTemp) newTemp(SAEOilNum,oldTemp,initialOilTemp,R,c,RPM,P,L,radialLoad) - oldTemp;
%             x = initialOilTemp:200;
%             figure
%             plot(x,fun(x))
% fun(initialOilTemp*0.99)
% fun(150)
            oilTemp = fzero(fun,[initialOilTemp*0.99,150]);
            %oilTemp =40;
            mew=oilViscosity(SAEOilNum,0.5*(initialOilTemp+oilTemp));
S=getBearingCharacteristic(R,c,mew,RPM,P);
f=lookupCoefficientFriction(S,L/(R*2),R/c);
Q=lookupFlowRate(S,L/(2*R),R,c,RPM);
            i=i+1;
            disp("s "+S+" l "+L+" R "+R+" c "+c+" T "+oilTemp);
%             mew;
%             P;
%             R/c;
            if(oilTemp>91 || oilTemp<0) || f==0 || Q==0% || n==maxN)
                %disp("delete")
                continue;
            else
                
                minH = lookupMinFilmThickness(S,L/(2*R),c);
                if(minH>getMinH0(2*R) && minH<c)
%                     disp("add");
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

