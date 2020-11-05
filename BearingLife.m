function [life] = BearingLife(bearing,load,reliability)
    %BEARINGLIFE calculate the fatigue life of the bearing
    %   INPUTS: bearing - 1 line table of bearing stats following catalog
    %                    format
    %           load: the equialent load the bearing is subjected to (kN)
    %           reliability: the % chance of bearing meeting the life
    %   OUTPUTS: life - the number of revolutions the bearing will last

    %extract info from the bearing table
    type = table2array(bearing(1,1));
    ratedLife = table2array(bearing(1,8));
    ratedLoad = table2array(bearing(1,6));

    %check for fatigue
    %set the exponent in the fatigue equation (from txtbook)
    if(type == "deepBall" || type == "angularBall")
        exp = 10/3;
    else
        exp = 3/10;
    end

    %set application factor based on loading type
    ka = 1.0;%set to 1 for constant laoading, no acceleration

    %calculatet the reliability factor based on the specified reliability
    %percent. from txtbook.
    if(reliability>90)
        kr = (-0.8/9)*(reliability-90)+1;
    elseif(reliability>50)
        kr = (-4/40)*(reliability-50)+5;
    else
        error('reliability must be above 50%')
    end

    %calculate the fatigue life
    life = kr*ratedLife*(ratedLoad/(ka*load))^exp;

end

