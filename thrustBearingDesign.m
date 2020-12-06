function [possibleBearings] = thrustBearingDesign(R1,W,RPM,SAEnum,oilTin,ThrustBearingData)
%R1 - internal radius, in metres
% W - thrust load, in newtons
%RPM - obvious 
%SAEnum - the sae designation of the oil used 
%oilTin - the temperature of the oil entering the bearing
% ThrustBearinData - the data file containing all the lookup info for
% thrust bearings

possibleBearings =[];

index=0;
%loop through all possible values of deltaR (L)
for L=0.1*R1:0.05:R1
    index = index+1
    %assuming B=L, calcualte the number of pads, then round to the nearest
    %integer
    x=round((0.5*L+R1)*2*pi()/(1.1*L));
    
    %calcualte B with the rounded x
    B=2*pi()*(R1+0.5*L)/(x*1.1);
    lengthRatio = L/R1;
    
    %create matrix with interpolated values from chart at the actual length
    %ratio
    newArray = zeros(16,6);
        for j=1:16
            newArray(j,1)=lengthRatio;
            X = [table2array(ThrustBearingData(j,1)); table2array(ThrustBearingData(j+16,1));table2array(ThrustBearingData(j+32,1))];
            for m=2:6
                Y=[table2array(ThrustBearingData(j,m)); table2array(ThrustBearingData(j+16,m));table2array(ThrustBearingData(j+32,m))];
                newArray(j,m)=interp1(X,Y,lengthRatio,'Linear','extrap');
            end
        end
    %iterate beta from 1 to 30 degrees    
    newnewArray=zeros(4,6);
    for n=1:2:30
        %interpolate all the values at this beta from table
        for k=4:4:16
            newnewArray(k/4,1) = lengthRatio;
            newnewArray(k/4,2) = n;%beta
            X=[newArray(k-3,2); newArray(k-2,2); newArray(k-1,2);newArray(k,2)];
            for m=3:6
                Y=[newArray(k-3,m); newArray(k-2,m); newArray(k-1,m);newArray(k,m)];
                newnewArray(k/4,m) = interp1(X,Y,n,'Linear','extrap');
                
            end
            if(newnewArray(k/4,5)<0)
                newnewArray(k/4,5)=0;
            end
            
            %calculate parameters with interpoalted data
            P = thrustUnitLoad(W,x,L,R1,n)* 1e-3;
            d0 = L*tand(n);
            h2 = newnewArray(k/4,3)*d0;

            newnewnewArray(k/4,:) = [L R1 B x n d0 h2 P newnewArray(k/4,4:6)];
        end
        
        %add this bearing to the possible bearings list
        possibleBearings = [possibleBearings; newnewnewArray];
    end
    n
end

%loop through list of possible bearings and remove things that cant meet
%requirements
i=1;
z=length(possibleBearings(:,1))
mew = oilViscosity(SAEnum,oilTin);
possibleBearings
while(i<=z)
    %actual H
    possibleBearings(i,11) = (possibleBearings(i,4)*possibleBearings(i,11)*mew*pi()*(RPM/60)^2*(possibleBearings(i,1)+possibleBearings(i,2))^4 / possibleBearings(i,6)) * 1e-6;
    %actual P
    possibleBearings(i,9) = mew*RPM/(60*possibleBearings(i,9))*(possibleBearings(i,1)/possibleBearings(i,6))^2;
    if (possibleBearings(i,4) >10 || possibleBearings(i,10)<=0 || possibleBearings(i,9)<possibleBearings(i,8))
        possibleBearings(i,:)=[];
        
        %counters to determine end of while loop
        i=i-1;
        z=z-1;
        if(mod(z,20)==0)
            z
        end
    end
    i=i+1;
end

%return remianing list of possible bearings
end
