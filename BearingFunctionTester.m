%comment this

RPM = 3600;

% add variable for gearclearance to bearings
% add left/right gear/pinion switches
[X Y] = BearingForceEquillibrium(6.2,6.2,6.2,6.2,1,16048,1205,0,[94965 94965 0],[0,723633,0])

possibleTypes = typesAllowed(Y,"singleHelical")

fe=zeros(length(possibleTypes),1);
for(i=1:(length(possibleTypes)))
    fe(i)=BearingFe(Y,possibleTypes(i));
end
fe

global catalog;
possibleBearings = catalog(1,:);
for i=1:length(possibleTypes)
    BearingFind(catalog,RPM,possibleTypes(i),fe(i)/1000,95,150);
    possibleBearings = [possibleBearings; ans];
end
possibleBearings(1,:) = [];

possibleTypes()
lives = [];
for(i=1:height(possibleBearings))
    findex = find(ismember(possibleTypes,string(table2cell(possibleBearings(i,1)))));
    lives = [lives; BearingLife(possibleBearings(i,:),fe(findex(1))/1000,99)];
end
lives2 = table(lives);
possibleBearings = [possibleBearings, lives2]

% oilViscosity = 10;
% type = possibleTypes(1);
% ID = table2array(possibleBearings(1,2));
% OD = table2array(possibleBearings(1,3));
% width = table2array(possibleBearings(1,4));
% staticLoad =table2array(possibleBearings(1,6));
% BearingHeat(BearingFriction(fe,6000,type,OD,ID,width,staticLoad,oilViscosity),6000)
