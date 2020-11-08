function [ r_gear,P] = kermit(gear_ratio,phi,psy,omega_in)
%Kermit take in the gear ratio, radius of input gear, helix angle and
%pressure angle of gears, and angular velocity of input gear in rpm and
%uses it to find potential value of P that will allow the bending stress,
%surface fatigue stress and contact ratio to agree.

for r_gear=1:24
    for P=1:16
        Vg=find_gear_velocity(r_gear,omega_in);
        Kv=(78+sqrt(Vg))/78;
        I=(sind(phi)*cosd(phi)*(gear_ratio))/(2*((gear_ratio)+1)); 
        Wdot=13410; % in HP
        Ft=33000*Wdot/Vg; %in lb
        Ko=1;% from table 15.1, assuming uniform power and shock
        Km=1.35; %this is a guess. WIll chekafter b is solved for
        J=0.8; % as much of a guess as they come
        b=find_gear_width(P);

        inf_life=find_endur_lim(P,1); %assuming pitch is greater than 5
        sigma=find_sigma(Ft,P,Kv,Ko,Km,b,J); %finding pitch that gives intifite life for bending stress
        
        CR=find_CR(r_gear,gear_ratio,P);
        sigma_h=find_sigma_h(P,r_gear,CR,Ft,psy,b,Kv,Ko,Km,I);

        Sfe=(0.4*(363)-10);
        Cli=0.8; %for 10^11 cycles
        Cr=1; % for %99 reliability
        SH=Cr*Cli*Sfe*1000;

        if (1.5<CR)&&(CR<2)
            if sigma_h<SH
                if sigma<inf_life
                    A=[r_gear,P]
            end
        end
        end
    end
    

end
end

