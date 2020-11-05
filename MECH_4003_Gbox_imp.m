%TRYING TO CONVERT TO IMPERIAL
%Script to keep track of all assumptions and constants used for gear
%calculations
%initial choice of material 9310 ALLOY STEEL
%Choice is somewhat arbitraty but 9310 is good gear material

%defined project paramters
omega=6000 %in RPM
omega_out=3600 %in RPM
Wdot=134102 %in HP
prompt='enter pitch ';
P=input (prompt)
prompt2='throw gear nums in bud ';
n=input(prompt2);

for i=1:n
    
    if i==1
        Sn=find_endur_lim(P,1)
    elseif i==n
        Sn=find_endur_lim(P,1)
    else
        Sn=find_endur_lim(P,2)
    end
    
    if i==1
        r_gear=1;
        sigma=find_gear_bend_stress(P,omega,Wdot,r_gear);
        while Sn<sigma
            r_gear=r_gear+1;
            sigma=find_gear_bend_stress(P,omega,Wdot,r_gear);
        end
        r_gear
        sigma=find_gear_bend_stress(P,omega,Wdot,r_gear);
    end
    omega=omega/(1.67^(1/n))
    r_gear=r_gear/(1.67^(1/n))
    i=i+1;
end
        