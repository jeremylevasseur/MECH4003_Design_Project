function [obj, grad] = rosenbrock(inputVariables, extraParams)
% ROSENBROCK Compute objective function value.
% 
% This function computes the objective value.
% Update the generated code to add the objective gradient computation.
% 
% OBJ = rosenbrock(INPUTVARIABLES, EXTRAPARAMS) computes the objective
% value OBJ at the point INPUTVARIABLES, using the extra parameters in
% EXTRAPARAMS.
% 
% [OBJ, GRAD] = rosenbrock(INPUTVARIABLES, EXTRAPARAMS) additionally
% computes the objective gradient value GRAD at the current point.
% 
% Auto-generated by prob2struct on 19-Nov-2020 08:54:45
% 
% 

%% Variable indices.
idx_L = 1;
idx_R = 2;
idx_c = 3;

%% Map solver-based variables to problem-based.
L = inputVariables(idx_L);
R = inputVariables(idx_R);
c = inputVariables(idx_c);


%% Insert gradient calculation here.
% If you include a gradient, notify the solver by setting the
% SpecifyObjectiveGradient option to true.
if nargout > 1
    grad = [];
end

%% Compute objective function.

obj = (extraParams{3} .* ((((extraParams{1} ./ ((2 .* R) .* L)) .* (2 .* R)) .* (7 ./ (extraParams{2} ./ c))) ./ 2));

end