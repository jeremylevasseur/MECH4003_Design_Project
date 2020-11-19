function [y] = dankChartInterpolation(S,lengthRatio,X,A,B,C,D)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

%[val,i]=min((X-S))
%if(S>=X(1) && S<=X(length(X)))
  %  for(i=1:(length(X)-1))
   %     if(X(i)>=S && X(i+1)>=S)
            a = S*(A(length(X))-A(1))/(X(length(X))-X(1)) +A(1);
            b = S*(B(length(X))-B(1))/(B(length(X))-X(1)) +B(1);
            c = S*(C(length(X))-C(1))/(X(length(X))-X(1)) +C(1);
            d = S*(D(length(X))-D(1))/(X(length(X))-X(1)) +D(1);
%         end
%     end
% elseif(S<=X(1))
%     i=1;
%     a = S*(A(i+1)-A(i))/(X(i+1)-X(i)) +A(i);
%     b = S*(B(i+1)-B(i))/(B(i+1)-X(i)) +B(i);
%     c = S*(C(i+1)-C(i))/(X(i+1)-X(i)) +C(i);
%     d = S*(D(i+1)-D(i))/(X(i+1)-X(i)) +D(i);
% elseif(S>=X(1))
%     i=3;
%     a = S*(A(i+1)-A(i))/(X(i+1)-X(i)) +A(i);
%     b = S*(B(i+1)-B(i))/(B(i+1)-X(i)) +B(i);
%     c = S*(C(i+1)-C(i))/(X(i+1)-X(i)) +C(i);
%     d = S*(D(i+1)-D(i))/(X(i+1)-X(i)) +D(i);
% end
y=(1/(lengthRatio^3))*((-1/8)*(1-lengthRatio)*(1-2*lengthRatio)*(1-4*lengthRatio)*d+(1/3)*(1-2*lengthRatio)*(1-4*lengthRatio)*c-(1/4)*(1-lengthRatio)*(1-4*lengthRatio)*b+(1/24)*(1-lengthRatio)*(1-2*lengthRatio)*a);
end

