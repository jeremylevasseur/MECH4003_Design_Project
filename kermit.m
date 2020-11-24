function [] = kermit(gear_ratio,phi,psy,omega_in)
%Kermit take in the gear ratio, radius of pinion gear, helix angle and
%pressure angle of gears, and angular velocity of input gear in rpm and
%uses it to find potential value of P that will allow the bending stress,
%surface fatigue stress and contact ratio to agree.
 z=1; %counter to find the row where the minimum volume occurs
 A=[0,0,0,0,0,0,0,0,0,0,0,0,0];
min_vol=1000000000000; % VARIABLE FOR MIN VOLUME
for b=1:2:60 %choosing range of gear width values to step through
   for r_pinion=12:1:36  %choosing range of pinion radii to step through
       for P=0.5:0.5:4  %choosing range of diametral pitch values to step through
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
                        vol=pi*(r_pinion^2)*b+pi*((gear_ratio*r_pinion)^2)*b;     
                        A=[A;r_pinion,P,b,SF_sigma,SF_sigma_h,CR,Np,Ng,Ft,sigma,sigma_h,vol,Ft]; %outputting results of possible values to an array
                        z=z+1;
                        if vol<min_vol
                            min_vol=vol;
                            row=z;
                        end
                    end
                end
            end
          
        end
        
   end
end

efficiency=effish(gear_ratio, A(row,1),A(row,2),psy,phi);%finding efficiency of gear mesh in percent**
heat_gen=100*(1-efficiency/100); %finding the power lost which is assumed to be completely transformed to heat 

fprintf('\n \nTo minimize volume of the gears, the pinion radius will be %4.2f inches,\n', A(row,1));
fprintf('the pitch will be %.2f teeth per inch of diameter,\n', A(row,2));
fprintf('the gear width will be %.2f inches, \n', A(row,3));
fprintf('the safety factor for bending stress will be %.2f, \n', A(row,4));
fprintf('the safety factor for surface fatigue stress will be %.2f, \n', A(row,5));
fprintf('the contact ratio will be %.2f, \n', A(row,6));
fprintf('the radial force will be %.2f lbs and the axal force will be %.2f lbs,\n', A(row,9)*cosd(phi),A(row,9)*cosd(psy)); 
fprintf('the volume of both gears combined will be %.2f in^3, \n', A(row,12));
fprintf('the tangential force is %.2f lbs, \n', A(row,13));
fprintf('the heat generated at the gear mesh is %.2f MW, \n', heat_gen);

