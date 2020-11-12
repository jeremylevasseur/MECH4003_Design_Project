function [types] = typesAllowed(F,gearArrangement)
%TYPESALLOWED determines which types of bearings are suitable for the
%application
%   INPUTS: f - the force vector on the bearing
%           gearArrangement - either "singleHelical" or "herringbone"
%   OUTPUTS: types - vector of acceptable bearing types

%create vector of all possible types
types = ["deepBall", "angularBall", "cylindricalRoller","taperRoller","sphericalRoller"];

%if there is any thrust force, cylindrical is unacceptable
if(F(1)~=0)
    types = types(find(types ~= "cylindricalRoller"));
end

%remove types based on gear artrangment. single helical requires a bearing
%that can locate
% if(gearArrangement =="singleHelical")
%      types = types(find(types ~= "deepBall"));
%      types = types(find(types ~= "cylindricalRoller"));
%      types = types(find(types ~= "sphericalRoller"));
% elseif(gearArrangement == "herringbone")
%     types = types(find(types ~= "angularBall"))
%     types = types(find(types ~= "taperRoller"))
% end

end

