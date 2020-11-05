%run loadCatalog() first time opening matlab or after making catalog
%changes

X = [0 1 0];
Y = [2 8 7];
[X Y] = BearingForceEquillibrium(1,2,1,1,1,0,0,0,[1 2 3],[4,0,0]);

possibleTypes = typesAllowed(X,"herringbone")

fe=zeros(size(possibleTypes));
for(i=1:1:(size(possibleTypes)+1))
    fe(i)=BearingFe(X,possibleTypes(i));
end
fe

global catalog;
BearingFind(catalog,1000,possibleTypes(1),fe(1)/1000,1.2,2)

BearingLife(ans(1,:),fe(1)/1000,99)

BearingHeat(BearingFriction(fe(1)),6000,OD, ID, width, oilViscosity)
