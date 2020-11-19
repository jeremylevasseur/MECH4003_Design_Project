R1 = 0.1503;%whatever the journal bearing is
possibleBearings =[];
W=22654;
RPM=3600;


for L=0.01:0.01:2*R1
    x=round(0.5+2*pi()*R1/L);
    B=2*pi()*(R1+0.5*L)/x;
    lengthRatio = L/R1;
    newArray = zeros(16,6);
        for j=1:16
            newArray(j,1)=lengthRatio;
            X = [table2array(ThrustBearingData(j,1)); table2array(ThrustBearingData(j+16,1));table2array(ThrustBearingData(j+32,1))];
            for m=2:6
                Y=[table2array(ThrustBearingData(j,m)); table2array(ThrustBearingData(j+16,m));table2array(ThrustBearingData(j+32,m))];
                newArray(j,m)=interp1(X,Y,lengthRatio,'Linear','extrap');
            end
        end
    newnewArray=zeros(4,6);
    for n=15:80
        for k=4:4:16
            newnewArray(k/4,1) = lengthRatio;
            newnewArray(k/4,2) = n;
            X=[newArray(k-3,2); newArray(k-2,2); newArray(k-1,2);newArray(k,2)];
            for m=3:6
                Y=[newArray(k-3,m); newArray(k-2,m); newArray(k-1,m);newArray(k,m)];
                newnewArray(k/4,m) = interp1(X,Y,n,'Linear','extrap');
            end
            P = thrustUnitLoad(W,x,L,R1,n)* 1e-3;
            d0 = L*tand(n);
            h2 = newnewArray(k/4,3)*d0;

            newnewnewArray(k/4,:) = [L R1 B x n d0 h2 P newnewArray(k/4,4:6)];
        end
    
    end
    possibleBearings = [possibleBearings; newnewnewArray];
end
i=1;
z=length(possibleBearings(:,1));
mew = oilViscosity(40,40);
while(i<=z)
    %actual H
    possibleBearings(i,11) = (possibleBearings(i,4)*possibleBearings(i,11)*mew*pi()*(RPM/60)^2*(possibleBearings(i,1)+possibleBearings(i,2))^4 / possibleBearings(i,6)) * 1e-6;
    %actual P
    
    if (possibleBearings(i,4) >10 || possibleBearings(i,10)<=0)
        possibleBearings(i,:)=[];
        i=i-1;
        z=z-1;
    end
    i=i+1;
end
%t = table("L","R1","B","x","beta","d0","h2","P","S","Q","H")
t = table();
t(1,:)=array2table(min(possibleBearings));
t.Properties.VariableNames = ["L","R1","B","x","beta","d0","h2","P","S","Q","H"];
t
