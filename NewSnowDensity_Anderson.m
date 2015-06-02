function newSnowDensity = NewSnowDensity_Anderson(...
    newSnowDenMin,bf,cf,airtemp,Tfreeze)

% This function calculates the density of newly fallen snow (not falling
% density!), based on air temperature along with three paramaters. 
% CLM and Noah use the following function (Essery et al. 2013).
% If multiple parameters are specified, all possible combinations are 
% computed and returned. Suggested Parameters are taken from Oleson et al. 2004.
% Original paper is from Anderson 1976

    % Anderson ES. A point energy and mass balance model of a snow cover.
    % NOAA Technical Report NWS 19, Office of Hydrology, National Weather
    % Service, 1976

    % Essery R., S. Morin , Y. Lejeune, C. B. Ménard, 2013: A comparison of
    % 1701 snow models using observations from an alpine site. Adv. Water
    % Resour. 55, 131-148

    % Oleson KW, et al. Technical description of the Community Land Model
    % (CLM). NCAR Technical Note NCAR/TN-461+STR; National Center for
    % Atmospheric Research, Boulder, CO., 2004
    
% RELEASE NOTES
%   Coded into Matlab by William Currier (currierw@uw.edu) June 2015
% 
% SYNTAX
%   newSnowDensity = NewSnowDensity_Anderson(newSnowDenMin,bf,cf,airtemp,Tfreeze)
% 
% INPUTS
% newSnowDenMin     - new snow minimum density (kg m-3)
% bf                - coeffecient (K-1)
% cf                - coeffecient (K)
% airtemp           - Air Temperature (K)
% Tfreeze           - Freezing Temperature of Liquid Water (K)

% Parameters taken from Oleson KW et al. 2004
% Paramter             Suggested      Min           Max
% newSnowDenMin   =    50.0000;       50.0000       200.0000 
% bf              =    1.7000;        unknown       unknown
% cf              =    15.0000;       unknown       unknown
% Tfreeze         =    273.1600;      272.1600;     276.1600;

% OUTPUTS
% newSnowDensity = Density of newly fallen snow over input timestep (kg m-3)
% 
% SCRIPTS REQUIRED
%  nones

%% Code %%

% Equation 7.18 in CLM Technical Note - Oleson KW, et al. 2004 Page 123

for a = 1:length(newSnowDenMin)
    for b = 1:length(bf)
        for c = 1:length(cf)
            
                for ii=1:length(airtemp)
                    
                    if airtemp(ii)>(Tfreeze+2) %unlikely to have snow higher than this temperature
                        newSnowDensity(a,b,c,ii)=newSnowDenMin(a)+(bf(b).*(17^1.5));
                    end
                    if airtemp(ii)>Tfreeze-15 && airtemp(ii)<=Tfreeze+2 % majority of winter air temperatures fall in this range
                        newSnowDensity(a,b,c,ii)=newSnowDenMin(a)+(bf(b).*((airtemp(ii)-Tfreeze+cf(c))^1.5));
                    end
                    if airtemp(ii)<=Tfreeze-15 %very cold snow has typically very low density
                        newSnowDensity(a,b,c,ii)=newSnowDenMin(a);
                    end
                    
                end
                
        end
    end
end
                    

% Check limits of density (can be exceded with given range of parameter
% space!)
newSnowDensity(newSnowDensity>900) = 900; % defined as ice
newSnowDensity(newSnowDensity<50) = 50; % Limit of fresh snow density
