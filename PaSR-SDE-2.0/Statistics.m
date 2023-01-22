% -----------------------------------------------------------------
% Statistics
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This function compute the evolution of statistics like PDF,
%  mean, variance, kurtosis etc.
% -----------------------------------------------------------------
    
% time instant
estat(1,istep+1) = time*omega; % 
    
% compute mean over each iteration in time
estat(2,istep+1) = mean(f_kf(:,1)); 
  
% compute variance over each iteration in time
estat(3,istep+1) = mean( ( f_kf(:,1) - mean(f_kf(:,1)) ).^2 ); 

% compute 4th moment over each iteration in time
var_qrta         = mean( ( f_kf(:,1) - mean(f_kf(:,1)) ).^4 );
estat(4,istep+1) = var_qrta / estat(3,istep+1)^2;

% compute 6th moment over each iteration in time
var_sxta         = mean( ( f_kf(:,1) - mean(f_kf(:,1)) ).^6 );
estat(5,istep+1) = var_sxta / estat(3,istep+1)^3;
% -----------------------------------------------------------------