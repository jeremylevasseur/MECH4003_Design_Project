function [Sn] = find_endur_lim(P,type)
%find_endur_lim Takes in ultimate stress of gear material, pitch of gears,
%and type of gear and outputs the infinite life endurance limit
% 'Su' Ultimate stress is based on material selection. In PSI
% 'P' is stepped through for a range of values
% 'type' is either input/output gear or intermediate gear

Su= 187000; %tensile strength in psi
SprimeN= 0.5*Su;
CL=1; %bending load
 % for P>5 but 0.85 for P<=5
if P>5
    Cg=1;
end
if P<=5
    Cg=0.85;
end

Cs=0.85; %for specific material assuming finely ground figure 8.13
Kr=0.814;%table 15.3 assuming 99% reliability
Kt=1; %if lubrication temp is less than 160F
%Kt=620/(460+300); %where 300 is the lub temp

%type 1 is input/output gear, type 2 is intermediate gear
if type==1
    kms=1.4;
end
if type==2
    kms=1;
end
    
Sn=SprimeN*CL*Cg*Cs*Kr*Kt*kms; %infinite life endurance limit



