
function[sigma]= find_sigma(Ft,P,Kv,Ko,Km,b,J);

%Find sigma calculates the bending stress in gear teeth

sigma= (Ft*P*Kv*Ko*0.93*Km)/(b*J);
end

