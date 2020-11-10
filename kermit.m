function [] = kermit(gear_ratio,phi,psy,omega_in)
%Kermit take in the gear ratio, radius of pinion gear, helix angle and
%pressure angle of gears, and angular velocity of input gear in rpm and
%uses it to find potential value of P that will allow the bending stress,
%surface fatigue stress and contact ratio to agree.
 
 A=[0,0,0,0,0,0,0,0,0,0,0];

for b=1:0.5:60 %choosing range of gear width values to step through
   for r_pinion=12:0.25:36  %choosing range of pinion radii to step through
       for P=0.5:0.1:4  %choosing range of diametral pitch values to step through
            Vg=find_gear_velocity(r_pinion,omega_in); %finding velocity at gear interface
            Kv=(78+sqrt(Vg))/78; %Dynamic factor, following curve for finely ground gear
            I=(sind(phi)*cosd(phi)*(gear_ratio))/(2*((gear_ratio)+1)); %finding geometry factor
            Wdot=134102; % Power tansmitted by gears in HP
            Ft=33000*Wdot/Vg; %Force at gear interface in lb
            Ko=1;% Overload factor,from table 15.1, assuming uniform power and shock
            if 0<=b<=6 %finding the mounting factor which is based on gear width
                    Km=1.3;
                elseif 6<b<=9
                    Km=1.4;
                elseif 9<b<=16
                    Km=1.5;
                else
                    Km=1.8;
            end
            
            Np=find_num_teeth(P,r_pinion); %number of teeth on pinion 
            Ng=Np*gear_ratio; %number of teeth on gear
            if 0<=Np<=20 %finding geometry factor which depends on the number of gear teeth
                J=0.42;
            elseif 20<Np<=60
                J=0.51;
            elseif 60<Np<=150
                   J=0.58;
            elseif 150<Np
                J=0.62;
            end
            
            inf_life=find_endur_lim(P,1); %finding infinite life endurance limit for bending stress. Assuming gears are input/output gears
            sigma=find_sigma(Ft,P,Kv,Ko,Km,b,J); %finding tooth bending stress

            CR=find_CR(r_pinion,gear_ratio,P,phi,Np); %finding contact ratio
            sigma_h=find_sigma_h(P,r_pinion,CR,Ft,psy,b,Kv,Ko,Km,I); %finding the surface fatigue stress

            Sfe=(0.4*(363)-10); %finding surface fatigure strength which is based on brinell hardness of material
            Cli=0.8; % life factor for 10^11 cycles
            Cr=1; %reliability factor for %99 reliability;
            SH=Cr*Cli*Sfe*1000; %finding surface fatigue stress endurance limit
            
            if (1.5<CR)&&(CR<2) %ensuring CR is between 1.5 and 2
                if sigma_h<((2/3)*SH) %making sure surface fatigue stress is less than surface fatigue stress endurance limit with a SF of 1.5
                    SF_sigma_h=SH/sigma_h; %calculating safety factor for surface fatigue stress
                    if sigma<(2*inf_life)%ensuring bending stress is less than infinite life endurance limit by a SF of 2
                        SF_sigma=inf_life/sigma; %calculating safety factor for tooth bending stress
                        A=[A;r_pinion,P,b,SF_sigma,SF_sigma_h,CR,Np,Ng,Ft,sigma,sigma_h]; %outputting results of possible values to an array
              
                    end
                end
            end
          
        end
        
   end
end
T=array2table(A,'VariableNames',{'Pinion_Radius','Pitch','Gear_Width','Safety_Factor_Bending_Stress','Safety_Factor_Surface_Stress','Contact_Ratio','Num_Teeth_Pinion','Num_Teeth_Gear','Force','sigma','sigma_h'})
end

