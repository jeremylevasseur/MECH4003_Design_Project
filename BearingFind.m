function [potentials] = BearingFind(catalog,RPM,type,load,minID,maxID)
%BEARINGFIND finds suitable bearings from catalog
%   Inputs: catalog - table of all possible bearings - see format
%                     requirements
%           RPM - the max operating RPM of the bearing
%           type - bearing type - see types allowed
%           load - the equivalent load on the bearing (kN)
%           minID - the minimum internal diameter of the bearing (mm)
%           maxID - the maximum internal diameter (mm)
%   OUTPUTS: potentials - table with same format as catalog with all
%                         bearings that meet requirements

%creat format for potentials by copying first row from catalogs
potentials = catalog(1,:);

%create vectors from catalog of the types and ID comlumns for faster
%looping
tabletypes = table2array(catalog(:,1));
tableIDs = table2array(catalog(:,2));

%loop through the type/ID vector to see if they meet the specs
for(i=2:height(catalog))
        if(tabletypes(i)==type && tableIDs(i)>=minID && tableIDs(i)<=maxID)
            %if the bearing meets the specs, add it to potentials list
            potentials = [potentials; catalog(i,:)];
    end
end

%loop through the selected potentials and check if the meet the speed and
%load specs
z=height(potentials);
i=2;
while(i<=z)
    %check if max bearing load is less than specified load
    if(table2array(potentials(i,5)) <= load)
        %if yes, remove the bearing from the potential list
        potentials(i,:) = [];
        i=i-1;
        z=z-1;
    %check if max bearing speed is less than specified speed
    elseif(table2array(potentials(i,9)) <= RPM) %use elseif so row cannot be removed twice
        %if yes, remove the bearing from the potential list
        potentials(i,:) = [];
        i=i-1;
        z=z-1;
    end
    i=i+1;
end

%remove the first row of the potentials list (placeholder from the
%beggining)
potentials([1],:)=[];

%return the potential bearing list
end

