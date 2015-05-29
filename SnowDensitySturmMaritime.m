%  Rho = SnowDensitySturmAlpine(t,z)
%    where t ~ times at which to compute density, in datetime format
%          z ~ depth corresponding to time t [mm]

function Rho = SnowDensitySturmMaritime(t,z)

%make sure depth is oriented correctly
if size(z,1)>size(z,2),
    z=z';
end
%blahhhhh
%convert depth in mm to cm
z=z./10;

%From Sturm et al. 2010 for the Alpine class

%Density parameters: from Table 4
RhoMax=.5979; 
Rho0=.2578;
k1=.0010;
k2=.0038;

%get DOY
[Y,MO,D] = datevec(t);
DOY = dayofyear(Y',MO',D');
for i=1:length(DOY),
    if DOY(i)>=dayofyear(Y(i),10,1),
        if isleapyear(Y(i)),
            DaysInYear=366;
        else
            DaysInYear=365;
        end
        DOY(i)=DOY(i)-DaysInYear;
    end
end

Rho=(RhoMax-Rho0).*(1-exp(-k1.*z-k2.*DOY))+Rho0;
Rho(z==0)=0; %set rho to zero everywhere there is no observation
Rho=Rho.*1000; %convert from g/cm3 to kg/m3

return