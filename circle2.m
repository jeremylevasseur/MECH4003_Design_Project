function [cineq, ceq, cineqGrad, ceqGrad] = circle2(InputVariables, extraParams)
% CIRCLE2 Compute constraint values.
% 
% This function computes the constraint values.
% Update the generated code to add the constraints gradient computation.
% 
% [CINEQ, CEQ] = circle2(INPUTVARIABLES, EXTRAPARAMS) computes the
% inequality constraint values CINEQ and the equality constraint values CEQ
% at the point INPUTVARIABLES, using the extra parameters in EXTRAPARAMS.
% 
% [CINEQ, CEQ, CINEQGRAD, CEQGRAD] = circle2(INPUTVARIABLES, EXTRAPARAMS)
% additionally computes the inequality constraint gradient values CINEQGRAD
% and the equality constraint gradient values CEQGRAD at the current point.
% 
% Auto-generated by prob2struct on 19-Nov-2020 08:54:45
% 
% 

%% Variable indices.
idx_L = 1;
idx_R = 2;
idx_c = 3;

%% Map solver-based variables to problem-based.
L = InputVariables(idx_L);
R = InputVariables(idx_R);
c = InputVariables(idx_c);


%% Insert gradient calculation here.
% If you include a gradient, notify the solver by setting the
% SpecifyConstraintGradient option to true.
if nargout > 2
    cineqGrad = [];
    ceqGrad = [];
end

%% Compute inequality constraints.
cineq = zeros(2,1);
arg1 = ((((((R ./ c).^2 .* extraParams{1}) .* 3600) ./ ((extraParams{2} ./ ((2 .* R) .* L)) .* 60)) .* extraParams{3}) ./ extraParams{4});
arg2 = (1 - (4 .* (L ./ (2 .* R))));
arg3 = ((((((R ./ c).^2 .* extraParams{7}) .* 3600) ./ ((extraParams{8} ./ ((2 .* R) .* L)) .* 60)) .* extraParams{9}) ./ extraParams{10});
arg4 = ((((extraParams{6} .* (1 - (L ./ (2 .* R)))) .* (1 - (2 .* (L ./ (2 .* R))))) .* arg2) .* (arg1 + extraParams{5}));
arg5 = (((extraParams{12} .* (1 - (2 .* (L ./ (2 .* R))))) .* (1 - (4 .* (L ./ (2 .* R))))) .* (arg3 + extraParams{11}));
arg6 = ((((((R ./ c).^2 .* extraParams{13}) .* 3600) ./ ((extraParams{14} ./ ((2 .* R) .* L)) .* 60)) .* extraParams{15}) ./ extraParams{16});
arg7 = (((extraParams{18} .* (1 - (L ./ (2 .* R)))) .* (1 - (4 .* (L ./ (2 .* R))))) .* (arg6 + extraParams{17}));
arg8 = ((((((R ./ c).^2 .* extraParams{19}) .* 3600) ./ ((extraParams{20} ./ ((2 .* R) .* L)) .* 60)) .* extraParams{21}) ./ extraParams{22});
arg9 = (((extraParams{24} .* (1 - (L ./ (2 .* R)))) .* (1 - (2 .* (L ./ (2 .* R))))) .* (arg8 + extraParams{23}));
arg10 = (((((((1 ./ (L ./ (2 .* R)).^3) .* (((arg4 + arg5) - arg7) + arg9)) .* R.^2) .* c) .* 3600) ./ 60) .* (L ./ (2 .* R)));
optim_problemdef_LHS = (40 + ((((extraParams{25} .* (R .* 2)) .* (7 ./ (R ./ c))) ./ 2) ./ ((arg10 .* 2) .* 1220)));

optim_problemdef_RHS = 91;
cineq(1) = optim_problemdef_LHS - optim_problemdef_RHS;

optim_problemdef_LHS = (extraParams{26} ./ ((2 .* R) .* L));

optim_problemdef_RHS = 1500000;
cineq(2) = optim_problemdef_LHS - optim_problemdef_RHS;

%% Compute equality constraints.
ceq = [];


end