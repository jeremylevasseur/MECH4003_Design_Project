function [Fe] = BearingFe(F,type)
    %BEARINGFE Calculate the equivalent load on the bearing based on axial and
    %           radial loads
    %   INPUTS: F - vector of x,y,z loads on bearing , x is axial
    %           type - the bearing type, see the allowed types
    %   OUTPUTS: Fe - scalar of equivalent load on bearing

    %resolve 3 axis loads into readial and axial
    Ft = F(1);
    Fr = sqrt(F(2)^2 + F(3)^2);

    %throw error if cylindrical roller with axial load
    if(type == "cylindricalRoller" && Ft>0)
        error('Cylindrical Roller Bearings cannot take thrust loads');
    end

    %calculate e factor
    e = Ft/Fr;

    %calculate the Fe based on equations and e-factor of each bearing type
    if(type == "deepBall")
        emax = 10^(0.235*log(e)-0.29);
        if(e>emax)
            y = 10^(0.235*log(e)-0.70);
            Fe = 0.56*Fr+y*Ft;
        else
            Fe = Fr;
        end
    elseif(type == "angularBall")
        emax = 1.14;
        if(e>emax)
            Fe = 0.35*Fr + Ft*0.57;
        else
            Fe = Fr;
        end
    elseif(type == "cylindricalRoller")
        Fe = Fr;
    elseif(type == "taperRoller")
        emax = 0.4;
        if(e>emax)
            y = 1.6;
            Fe = 0.4*Fr + Ft*y;
        else
            Fe = Fr;
        end
    elseif(type == "sphericalRoller")
        emax = 0.28;
        if(e>emax)
            y=3.6;
            Fe = 0.67*Fr+y*Ft;
        else
            y = 2.6;
            Fe=Fr+y*Ft;
        end
    else
        error("Invalid Bearing Type");
    end


end

