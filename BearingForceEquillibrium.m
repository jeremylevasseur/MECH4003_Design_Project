function [Fa,Fb] = BearingForceEquillibrium(La,Lb,Cgg,Cgs,Cgc,Mg,Ms,Mc,Fapplied,Mapplied)
    %BEARINGFORCES calcualte the x,y,z forces on 2 bearings (no moments on
    %               them)
    %   INPUTS: La - distance from left bearing to Fapplied/Mapplied
    %                   location
    %           Lb-distance from left bearing to right bearing
    %           Cgg,Cgs,Cgc - the distance from left bearing to the center of
    %                         gravity of the gear, shaft and coupling
    %           Mg,Ms,Mc - the mass of the gear, shaft and coupling
    %           Fapplied,Mapplied - the force and moment applied to the shaft
    %                                by the gear (x,y,z) vectors
    %   OUTPUTS: Fa - force on left bearing (x,y,z) vector
    %            Fb - force on the right bearing (x,y,z) vector

    G = 9.81;%gravitational constant

    %initialize the return vectors
    Fa = zeros(1,3);
    Fb = zeros(1,3);


    %calculate the x force. Left bearing takes leftward loads, right bearing
    %takes rightward. follows skf recommendations
    if(Fapplied(1)<0)
        Fa(1) = Fapplied(1);
    elseif(Fapplied(1)>1)
        Fb(1) = -Fapplied(1);
    end


    %solve Mxy about left bearing and Fy equations simultaneously
    b = [0;0];
    c = [G*(Mg+Ms+Mc)+Fapplied(2); G*(Mg*Cgg+Ms*Cgs+Mc*Cgc)+Mapplied(2)+Fapplied(2)*La];
    A = [1 1;
        0 Lb];
    b = A\c;

    Fa(2) = b(1);
    Fb(2) = b(2);


    %solve Mxz about left bearing and Fz equations
    b=[0;0];
    a=[0 Lb; -1 -1];
    c=[Mapplied(3)-Fapplied(3)*La; Fapplied(3)];
    b = A\c;

    Fa(3) = b(1);
    Fb(3) = b(2);
end

