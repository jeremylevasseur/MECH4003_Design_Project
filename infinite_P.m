function [ P ] = infinite_P(sigma,J,Kv,Ko,Km,Ft)
%Infinite P finds the Pitch of a gear interface required in order to hae
%the bending stress<infinite life endurance limit when al other paramters
%are known.
%subbed in 14/P for b
P=sqrt((sigma*14*J)/(Ft*Kv*Ko*0.93*Km));

end

