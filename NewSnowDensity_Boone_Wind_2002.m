function newSnowDensity = NewSnowDensity_Boone_Wind_2002(...
    a_sn,b_sn,c_sn,airtemp,wind_speed,Tfreeze)

% This function calculates the density of newly fallen snow (not falling
% density!), based on air temperature and wind speed along with three 
% paramaters. Crocus, HTESSEL and the ISBA-ES model use the following 
% parameters (Essery et al. 2013). If multiple parameters are specified, all
% possible combinations are computed and returned. Suggested Parameters are
% taken from Boone 2002 described on page 27.

% Boone A. Description du schema de neige ISBA-ES (Explicit Snow). Centre
% National de REcherches Métérologiques, Météo-France, Toulouse, 2002.
% Available from: http://www.cnrm.meteo.fr.IMG/pdf/snowdoc.pdf.

% Essery R., S. Morin , Y. Lejeune, C. B. Ménard, 2013: A comparison of
% 1701 snow models using observations from an alpine site. Adv. Water
% Resour. 55, 131-148
% 
% RELEASE NOTES
%   Coded into Matlab by William Currier (currierw@uw.edu) June 2015
% 
% SYNTAX
%   newSnowDensity = NewSnowDensity_Boone_Wind_2002(a_sn,b_sn,c_sn,airtemp,wind_speed,Tfreeze)
% 
% INPUTS
% a_sn              - coeffecient (kg m-3) - minimum snow density
% b_sn              - coeffecient (kg m-3 k-1)
% c_sn              - coeffecient [kg m-(7/2) s-(1/2)]
% airtemp           - Air temperature (K)
% wind_speed        - Wind Speed (m/s)
% Tfreeze           - Freezing Temperature of liquid water (K)

% The Dependence on wind speed is to suggest that the higher the windspeed
% the greater likelihood that the snow is broken into finer grains. As wind
% speed increases so does fresh snow denisty. Same relationship holds true
% with temperature. Minimum snow density allowed in this function is 50 kg m-3.
% Maximum is 900 kg m-3 but can be changed if needed at the end of the function.

% Suggested values based on Boone 2002
% Paramter             Default        Min           Max
% a_sn            =    109.0000;      unknown       unknown
% b_sn            =    6.0000;        unknown       unknown
% c_sn            =    26.0000;       unknown       unknown
% Tfreeze         =    273.1600;      272.1600;     276.1600;

% OUTPUTS
% newSnowDensity = Density of newly fallen snow over input timestep (kg m-3)
% 
% SCRIPTS REQUIRED
%  nones

%% Code %%


for a = 1:length(a_sn)
    for b = 1:length(b_sn)
        for c = 1:length(c_sn)
            newSnowDensity(a,b,c,:) = a_sn(a) + (b_sn(b) .* (airtemp-Tfreeze))+(c_sn(c).*((wind_speed).^0.5)); % new snow density (kg m-3)
        end
    end
end

% Check limits of density (can be exceded with given range of parameter
% space!)
newSnowDensity(newSnowDensity>900) = 900; % defined as ice
newSnowDensity(newSnowDensity<50) = 50; % Limit of fresh snow density based on Boone 2002

