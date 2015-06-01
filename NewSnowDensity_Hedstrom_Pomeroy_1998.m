function newSnowDensity = NewSnowDensity_Hedstrom_Pomeroy_1998(...
    newSnowDenMin,newSnowDenMult,newSnowDenScal,airtemp)

% This function calculates the density of newly fallen snow (not falling
% density!), based on air temperature and three paramters as described by
% Hedstrom and Pomeroy 1998. If multiple parameters are specified, all
% possible combinations are computed and returned.
% 
% Hedstrom, N. R., and J. W. Pomeroy (1998), Measurements and modelling of 
% snow interception in the boreal forest, Hydrological Processes, 12 (10-11),
% 1611-1625, doi: 10.1002/(sici)1099-1085(199808/09)12:10/11<1611::aid-hyp684>3.0.co;2-4.
% 
% RELEASE NOTES
%   Coded into Matlab by Nic Wayand (nicway@gmail.com) June 20015
% 
% SYNTAX
%   newSnowDensity = NewSnowDensity_Hedstrom_Pomeroy_1998(newSnowDenMin,newSnowDenMult,newSnowDenScal,airtemp)
% 
% INPUTS
% newSnowDenMin     - Mx1 minimum new snow density  (kg m-3), where N is each time
%                       step, and M is for each paramter combination
% newSnowDenMult    - Qx1 multiplier for new snow density (kg m-3)         
% newSnowDenScal    - Rx1 scaling factor for new snow density (K)      
% airtemp           - MxQxRxNAir temperature (K)
%
% Parameter limits within SUMMA
% Paramter             Default        Min           Max
% newSnowDenMin   =    100.0000;      50.0000       100.0000 
% newSnowDenMult  =    100.0000;      25.0000       75.0000
% newSnowDenScal  =    5.0000;        1.0000        5.0000
%
% OUTPUTS
% newSnowDensity = Density of newly fallen snow over intput timestep (kg m-3)
% 
% SCRIPTS REQUIRED
%  nones

%% Code %%

% Constants
Tfreeze = 273.16; % Freezing temperature of water
Den_ice = 917; % Density of ice (kg m-3)

for a = 1:length(newSnowDenMin)
    for b = 1:length(newSnowDenMult)
        for c = 1:length(newSnowDenScal)
            newSnowDensity(a,b,c,:) = newSnowDenMin(a) + newSnowDenMult(b) .* exp((airtemp-Tfreeze)./newSnowDenScal(c)); % new snow density (kg m-3)
        end
    end
end

% Check limits of density (can be exceded with given range of parameter
% space!)
newSnowDensity(newSnowDensity>Den_ice) = Den_ice; 
newSnowDensity(newSnowDensity<1) = 1; 








