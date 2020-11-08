function [CR] = find_CR( input_args )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

phi=0.349;
%change N below
a=(N+2)/(2*P);
I=(sin(phi)*cos(phi)*(gr))/(2*((gr)+1)); %R=dg/dp which is the gear ratio
rap=rg1+a; % pitch radius plus addendum for pinion (gear 1)
rbp=rg1-(1.25*a); %base radius as stated on pg. 571
rag=rg2+a; % pitch radius plus addendum for gear (gear 2)
rbg=rg2-(1.25*a); 
dp1=2*rg1; %finding pitch diam for both gears because they will have different surface fatigue stress
dp2=2*rg2;
c=rg1+rg2; %for calculating CR
db=2*rbp; %need base dia. for CR. Not sure which value to use though. CR should be same for both.
CR=((sqrt(rap^2-rbp^2))+(sqrt(rag^2-rbg^2))-(c*sin(phi)))/((3.14159*db)/(N)); %contact ratio


while CR<1.5
        a=a+0.01;
        rap=rg1+a; % pitch radius plus addendum for pinion (gear 1)
        rbp=rg1-(1.25*a); %base radius as stated on pg. 571
        rag=rg2+a; % pitch radius plus addendum for gear (gear 2)
        rbg=rg2-(1.25*a); 
        db=2*rbp;
        CR=((sqrt(rap^2-rbp^2))+(sqrt(rag^2-rbg^2))-(c*sin(phi)))/((3.14159*db)/(N)); %contact ratio
end

    while CR>2
        a=a-0.01;
        rap=rg1+a; % pitch radius plus addendum for pinion (gear 1)
        rbp=rg1-(1.25*a); %base radius as stated on pg. 571
        rag=rg2+a; % pitch radius plus addendum for gear (gear 2)
        rbg=rg2-(1.25*a); 
        db=2*rbp;
        CR=((sqrt(rap^2-rbp^2))+(sqrt(rag^2-rbg^2))-(c*sin(phi)))/((3.14159*db)/(N)); %contact ratio
    end
end

