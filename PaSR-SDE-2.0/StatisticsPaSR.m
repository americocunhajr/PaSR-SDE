% -----------------------------------------------------------------
% StatisticsPaSR
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This function compute the evolution of statistics like PDF,
%  mean, variance, kurtosis etc. for the PaSR
% -----------------------------------------------------------------
    
% time instant
estatPASR(1,istep_age+1) = time; 
    
% compute mean over each iteration in time
estatPASR(2,istep_age+1) = mean(f_kf(:,1)); 
  
% compute std. dev. over each iteration in time
estatPASR(3,istep_age+1) = sqrt(mean( ( f_kf(:,1) - mean(f_kf(:,1)) ).^2 )); 

% compute 4th moment over each iteration in time
var_qrta                 = mean( ( f_kf(:,1) - mean(f_kf(:,1)) ).^4 );
estatPASR(4,istep_age+1) = var_qrta; % non-normalized

% compute 6th moment over each iteration in time
var_sxta                 = mean( ( f_kf(:,1) - mean(f_kf(:,1)) ).^6 );
estatPASR(5,istep_age+1) = var_sxta; % non-normalized
% -----------------------------------------------------------------