function [frictionTorque] = BearingFriction(f,RPM,type,OD,ID,width,oilViscosity)
%FRICTION this function calculates the frictional torque of the bearing
%   Detailed explanation goes here


dm = (OD+ID)/2;
fr=sqrt(f(2)^2+f(3)^2);
phiish = 1/(1+1.84e-9 * (RPM*dm)^1.28 * oilViscosity^0.64);
if(type=="deepBall")
    kz = 3.1;
    r1 = 4.1e-7;
    r2=1.7;
    s1=3.73e-3;
    s2=36.5;
    grr=r1*dm^1.6 *(fr+r2*f(1)/(sind(24.6*(f(1)/statLoad)^0.24)))^0.54;
    uehl=0.04;
    gsl=s1*dm^(-0.145)*(fr^5 +(s28dm^1.5 *fa^4)/(sind(24.6*(f(1)/statLoad))))^0.33;
    kball=kz*(ID+OD)/(OD-ID) *10^-12;
    fa=0.05*kz*(ID+OD)/(OD-ID);
    Rs=0.36*dm^2*fa;
    mdrag = 0.4*Vm*kball*dm^5 *RPM^2 + 1.093e-7*rpm^2 *dm^3 *(RPM*dm^2 /oilViscosity)^-1.379 *Rs;
elseif(type=="angularBall")
    kz=4.4;
    r1=4.54e-7;
    r2=2.02;
    r3=1.84e-12;
    s1=1.64e-2;
    s2=0.71;
    s3=1.84e-12;
    grr=r1*dm^1.97 *(fr+r3*dm^3.5*RPM^2+r2*f(1))^0.54;
    uehl=0.04;
    gsl=s1*dm^0.26 *((fr+s3*dm^3.5*RPM^2)^1.33 +s2*f(1)^1.33);
    kball=kz*(ID+OD)/(OD-ID) *10^-12;
    fa=0.05*kz*(ID+OD)/(OD-ID);
    Rs=0.36*dm^2*fa;
    mdrag = 0.4*Vm*kball*dm^5 *RPM^2 + 1.093e-7*rpm^2 *dm^3 *(RPM*dm^2 /oilViscosity)^-1.379 *Rs;
elseif(type=="cylindricalRoller")
    kz=5.1;
    r1=1.4e-6;
    s1=0.16;
    s2=0.0015;
    grr=r1*dm^2.41*fr^0.31;
    uehl=0.02;
    gsl=s1*dm^0.9 *f(1) + s2*dm*fr;
    kroll=kl*kz*(ID+OD)/(OD-ID);
    fa=0.05*kz*(OD+ID)/(OD-ID);
    Rs=0.36*fm^2 *fa;
    id=5*kl*width/dm;
    cw=2.789e-3 *id^3 -2.786e-4*id^2 +0.0195*id +0.6439;
    mdrag=4*vm*kroll*cw*width*dm^4 *RPM^2 +1.093e-7 *RPM^2 *dm^3 *(RPM*dm^2/oilViscosity)^-1.379 *Rs;
elseif(type=="taperedRoller")
    kz=6;
    r1=2.31e-6;
    r2=10.9;
    s1=0.15;
    s2=2;
    grr=r1*dm^2.38 *(fr+r2*1.6*f(1))^0.31;
    uehl=0.002;
    gsl=s1*dm^0.82 *(fr+s2*1.6*f(1));
    kroll=kl*kz*(ID+OD)/(OD-ID);
    fa=0.05*kz*(OD+ID)/(OD-ID);
    Rs=0.36*fm^2 *fa;
    id=5*kl*width/dm;
    cw=2.789e-3 *id^3 -2.786e-4*id^2 +0.0195*id +0.6439;
    mdrag=4*vm*kroll*cw*width*dm^4 *RPM^2 +1.093e-7 *RPM^2 *dm^3 *(RPM*dm^2/oilViscosity)^-1.379 *Rs;
elseif(type=="sphericalRoller")
    kz=5.5;
    r1=2.3e-6;
    r2=4.1;
    r3=4e-6;
    r4=4.05;
    s1=8.66e-3;
    s2=126;
    s3=2.1e-2;
    s4=41;
    grr=min(r1*dm^1.85 *(fr+r2*f(1))^0.54,r3*dm^2.3 *(fr+r4*f(1))^0.31);
    uehl=0.04;
    gsl = min(s1*dm^0.25 *(fr^4 +s2*f(1)^4)^0.33,s3*dm^0.94 *(fr^3 +s4*f(a)^3)^0.33);
    kroll=kl*kz*(ID+OD)/(OD-ID);
    fa=0.05*kz*(OD+ID)/(OD-ID);
    Rs=0.36*fm^2 *fa;
    id=5*kl*width/dm;
    cw=2.789e-3 *id^3 -2.786e-4*id^2 +0.0195*id +0.6439;
    mdrag=4*vm*kroll*cw*width*dm^4 *RPM^2 +1.093e-7 *RPM^2 *dm^3 *(RPM*dm^2/oilViscosity)^-1.379 *Rs;
end
phirs = 1/exp(3e-8*RPM*oilViscosity*2*dm*sqrt(kz/(2*(OD-ID))));
mrr=phiish*phirs*grr*(oilViscosity*RPM)^0.6;

phibl=1/exp(2.6e-8 *(ROM*oilViscosity)^1.4 *dm);
usl=0.12*phibl+(1-phibl)*uehl;
msl=gsl*usl;



frictionTorque=mrr+msl+mdrag;
end

