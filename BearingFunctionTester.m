
[X Y] = BearingForceEquillibrium(1,2,1,1,1,0,0,0,[1 2 3],[4,0,0]);

possibleTypes = typesAllowed(X,"herringbone")

fe=zeros(size(possibleTypes));
for(i=1:1:(size(possibleTypes)+1))
    fe(i)=BearingFe(X,possibleTypes(i));
end
fe

global catalog;
possibleBearings = catalog(1,:);
for i=1:length(possibleTypes)
    BearingFind(catalog,1000,possibleTypes(i),fe(1),95,105);
    possibleBearings = [possibleBearings; ans]
end
possibleBearings(1,:) = [];

BearingLife(possibleBearings(1,:),fe(1)/1000,99)

oilViscosity = 10;
type = possibleTypes(1);
ID = table2array(possibleBearings(1,2));
OD = table2array(possibleBearings(1,3));
width = table2array(possibleBearings(1,4));
staticLoad =table2array(possibleBearings(1,6));
BearingHeat(BearingFriction(fe,6000,type,OD,ID,width,staticLoad,oilViscosity),6000)
