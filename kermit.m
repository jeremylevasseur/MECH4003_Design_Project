function [] = kermit(gear_ratio,phi,psy,omega_in)
%Kermit take in the gear ratio, radius of input gear, helix angle and
%pressure angle of gears, and angular velocity of input gear in rpm and
%uses it to find potential value of P that will allow the bending stress,
%surface fatigue stress and contact ratio to agree.
 
 A=[0,0,0,0,0,0,0,0,0];

for b=1:0.5:60
   for r_pinion=12:0.25:36  
       for P=0.5:0.1:4  
            Vg=find_gear_velocity(r_pinion,omega_in);
            Kv=(78+sqrt(Vg))/78; %finely ground gear
            I=(sind(phi)*cosd(phi)*(gear_ratio))/(2*((gear_ratio)+1)); 
            Wdot=134102; % in HP
            Ft=33000*Wdot/Vg; %in lb
            Ko=1;% from table 15.1, assuming uniform power and shock
            if 0<=b<=6
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
            if 0<=Np<=20
                J=0.42;
            elseif 20<Np<=60
                J=0.51;
            elseif 60<Np<=150
                   J=0.58;
            elseif 150<Np
                J=0.62;
            end
            
            inf_life=find_endur_lim(P,1); 
            sigma=find_sigma(Ft,P,Kv,Ko,Km,b,J); %finding pitch that gives intifite life for bending stress

            CR=find_CR(r_pinion,gear_ratio,P,phi,I,Np);
            sigma_h=find_sigma_h(P,r_pinion,CR,Ft,psy,b,Kv,Ko,Km,I);

            Sfe=(0.4*(363)-10);
            Cli=0.8; %for 10^11 cycles
            Cr=1; % for %99 reliability;
            SH=Cr*Cli*Sfe*1000;
            
            if (1.5<CR)&&(CR<2)
                if sigma_h<((2/3)*SH)
                    SF_sigma_h=SH/sigma_h;
                    if sigma<(2*inf_life)
                        SF_sigma=inf_life/sigma;
                        A=[A;r_pinion,P,b,SF_sigma,SF_sigma_h,CR,Np,Ng,Ft];
              
                    end
                end
            end
          
        end
        
   end
end
T=array2table(A,'VariableNames',{'Pinion_Radius','Pitch','Gear_Width','Safety_Factor_Bending_Stress','Safety_Factor_Surface_Stress','Contact_Ratio','Num_Teeth_Pinion','Num_Teeth_Gear','Force'})
Fa=Ft*tand(psy);
Fr=Ft*tand(phi);

end

