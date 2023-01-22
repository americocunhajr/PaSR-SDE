% -----------------------------------------------------------------
% Production
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This function describes the process of reaction.
%
%   Input :
%       C               :   Reaction progress variable.
%
%   Output :  
%       w_c             :   The dimensionless fuel production rate
% -----------------------------------------------------------------
function w_c = Production(C)

    % load input variables
    PaSR_Data
    
    % Reduced heat of reaction
    Alfa = (Tad-To)/To;

    % Reduced activation energy (1000 unit conversion)
    Beta_q = 1000*Ea/(R2*To); 
    
    % Average Molecular Weight (kg/kmol)
    W_medio = X_CH4*W_CH4 + X_O2*W_O2; 

    % Density of the mixture at the inlet (kg/m3) where R=0.287 KJ/kgK
    Rho = P_atm/(R1*To);  
    
    % Calculation of the characteristic time of the chemical reaction
    Tau_quim = (Rho/W_medio*X_CH4*X_O2*Af*exp(-Ea/(R2*To)))^-1;
    
    % The production rate of dimensionless fuel
    w_c = (1-C).*exp(Beta_q*(C./(C+1/Alfa)));

    % The progress of a single reaction (kmol/m3.s)
    % q_c = (Rho/(W_medio*Tau_q))*w_c;
end
% -----------------------------------------------------------