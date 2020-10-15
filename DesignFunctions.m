
classdef DesignFunctions
    methods
        
        function [returnStatement1, returnStatement2] = exampleFunction(obj, input1, input2)
            returnStatement1 = input1 * 20;
            returnStatement2 = input2 * 23;
        end
        
        function [a, CR] = gearRadiusToContactRatio(obj, gearRadius)

            %TRYING TO CONVERT TO IMPERIAL
            %Script to keep track of all assumptions and constants used for gear
            %calculations
            %initial choice of material 9310 ALLOY STEEL
            %Choice is somewhat arbitraty but 9310 is good gear material

            %defined project paramters
            omega_in=6000; %in RPM
            omega_out=3600; %in RPM
            Wdot=134102; %in HP

            rg1=gearRadius;
            rg2=rg1/1.67;
            psi=20;
            phi=20;

            %below are defined parameters for the endurance limit
            Su= 187000; %tensile strength in psi
            SprimeN= 0.5*Su;
            CL=1; %bending load
            Cg=1; % for P>5 but 0.85 for P<=5
            Cs=0.85; %for specific material assuming finely ground figure 8.13
            Kr=0.814;%table 15.3 assuming 99% reliability
            Kt=15; %if lubrication temp is less than 160F
            Kms= 1.4; %for input output gears and =1 for intermediate gears

            Sn=SprimeN*CL*Cg*Cs*Kr*Kt*Kms; %infinite life endurance limit

            %below are defined paremters for bending stress
            Vg=2*3.1415*(1/12)*rg1*omega_in; %velocity based on radius of first gear
            Ft=33000*Wdot/Vg; %force at gear interface, in lbs
            P=5; %I chose arbitrary pitch******revise 
            N=2*rg1*P; %calculating N to find b

            %p=(3.14159)/P %calc'ing p to find b
            %pa=p/tan(psi)% for a helical gear
            %b=2*pa %pg. 620 b>=2pa
            %using above expression to find b gave a very small value. Gonna try and
            %just guess b=1/4d
            b=1/2*rg1;
            J=0.5; %just kinda of guessed er and didn't actually calc # of teeth
            Kv=(78+sqrt(Vg))/78;
            Ko=1;% from table 15.1, assuming uniform power and shock
            if 0<=b<=2
                Km=1.3;
            elseif 2<b<=6
                Km=1.3;
            elseif 6<b<=9
                Km=1.4;
            elseif 9<b<=16
                Km=1.5;
            else
                Km=1.8;
            end

            sigma=(Ft*P*Kv*Ko*0.93*Km)/(b*J); %bending stress calculation, in psi


            %paramaters for surface fatigue
            Cp=2300; %from table 15.4, (Psi)^1/2

            %Pn=P*cos(psi); %calculating pitch in plane norma to teeth to find addendum length
            %a=1/Pn %addendum length
            %above equations are not yielding a value of a which gives proper CR (1-2)
            a=0.001;
            I=(sind(phi)*cosd(phi)*(1/1.67))/(2*((1/1.67)+1)); %R=dg/dp which is the gear ratio
            rap=rg1+a; % pitch radius plus addendum for pinion (gear 1)
            rbp=rg1-(1.25*a); %base radius as stated on pg. 571
            rag=rg2+a; % pitch radius plus addendum for gear (gear 2)
            rbg=rg2-(1.25*a); 
            dp1=2*rg1; %finding pitch diam for both gears because they will have different surface fatigue stress
            dp2=2*rg2;
            c=rg1+rg2; %for calculating CR
            db=2*rbp; %need base dia. for CR. Not sure which value to use though. CR should be same for both.

            chunk1 = sqrt((rap^2)- (rbp^2));
            chunk2 = sqrt((rag^2) - (rbg^2));
            chunk3 = c*sind(phi);
            p_b = (3.14159*db)/(N);
            CR = (chunk1 + chunk2 - chunk3) / (p_b);

            if CR<1.5
                while CR<1.5
                    a=a+0.01;
                    rap=rg1+a; % pitch radius plus addendum for pinion (gear 1)
                    rbp=rg1-(1.25*a); %base radius as stated on pg. 571
                    rag=rg2+a; % pitch radius plus addendum for gear (gear 2)
                    rbg=rg2-(1.25*a); 
                    db=2*rbp;
                    chunk1 = sqrt(rap^2-rbp^2);
                    chunk2 = sqrt(rag^2-rbg^2);
                    chunk3 = c*sind(phi);
                    p_b = (3.14159*db)/(N);
                    CR = (chunk1 + chunk2 - chunk3) / (p_b);
                end
                %fprintf('1\n')
                %fprintf('CR = %f\n', CR)
                %fprintf('a = %f\n', a)
            end

            if CR>2
                while CR>2
                    a=a-0.01;
                    rap=rg1+a; % pitch radius plus addendum for pinion (gear 1)
                    rbp=rg1-(1.25*a); %base radius as stated on pg. 571
                    rag=rg2+a; % pitch radius plus addendum for gear (gear 2)
                    rbg=rg2-(1.25*a); 
                    db=2*rbp;
                    chunk1 = sqrt(rap^2-rbp^2);
                    chunk2 = sqrt(rag^2-rbg^2);
                    chunk3 = c*sind(phi);
                    p_b = (3.14159*db)/(N);
                    CR = (chunk1 + chunk2 - chunk3) / (p_b);
                end
                %fprintf('2\n')
                %fprintf('CR = %f\n', CR)
                %fprintf('a = %f\n', a)
            end

            return 

        end
    end
end