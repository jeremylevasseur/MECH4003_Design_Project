function [viscosity] = oilViscosity(SAEnumber,temp)
%UNTITLED Summary of this function goes here
%   viscosity = mPa s
% SAEnumber=10,20,30,40,50,60,70;
rho=(0.89*0.00063*(temp-15.6))*100^3/1000;
viscosity = 120;
x=[20;130];
viscosityVector=[feval(fit(x,[115;2.2],'exp1'),temp);feval(fit(x,[180;2.7],'exp1'),temp);
    feval(fit(x,[350;3.5],'exp1'),temp);feval(fit(x,[600;4.2],'exp1'),temp);
    feval(fit(x,[1000;6],'exp1'),temp);feval(fit(x,[1600;7.5],'exp1'),temp);
    feval(fit(x,[2500;9],'exp1'),temp)];

viscosity = viscosityVector(SAEnumber/10)/(rho*1000);
end

