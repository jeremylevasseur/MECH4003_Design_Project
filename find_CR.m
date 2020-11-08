function [CR] = find_CR( r_gear,gear_ratio,P)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

phi=0.349;
%change N below
N=find_num_teeth(P,r_gear);
ra1=(N+2)/(2*P);
rd1=(N-2.5)/(2*P);
ra2=(((gear_ratio)*N)+2)/(2*P);
rd2=(((gear_ratio)*N)-2.5)/(2*P);
I=(sin(phi)*cos(phi)*(gear_ratio))/(2*((gear_ratio)+1)); %R=dg/dp which is the gear ratio
c=r_gear+(gear_ratio)*r_gear; %for calculating CR
db=2*r_gear; %need base dia. for CR. Not sure which value to use though. CR should be same for both.
CR=((sqrt(ra1^2-rd1^2))+(sqrt(ra2^2-rd2^2))-(c*sin(phi)))/((3.14159*db)/(N)); %contact ratio


% while CR<1.5
%         a=a+0.01;
%         rap=rg1+a; % pitch radius plus addendum for pinion (gear 1)
%         rbp=rg1-(1.25*a); %base radius as stated on pg. 571
%         rag=rg2+a; % pitch radius plus addendum for gear (gear 2)
%         rbg=rg2-(1.25*a); 
%         db=2*rbp;
%         CR=((sqrt(rap^2-rbp^2))+(sqrt(rag^2-rbg^2))-(c*sin(phi)))/((3.14159*db)/(N)); %contact ratio
% end
% 
%     while CR>2
%         a=a-0.01;
%         rap=rg1+a; % pitch radius plus addendum for pinion (gear 1)
%         rbp=rg1-(1.25*a); %base radius as stated on pg. 571
%         rag=rg2+a; % pitch radius plus addendum for gear (gear 2)
%         rbg=rg2-(1.25*a); 
%         db=2*rbp;
%         CR=((sqrt(rap^2-rbp^2))+(sqrt(rag^2-rbg^2))-(c*sin(phi)))/((3.14159*db)/(N)); %contact ratio
%     end
end

