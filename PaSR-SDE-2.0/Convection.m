% -----------------------------------------------------------------
% Convection
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This function simulates the input/output process of particles
%  contained in a reactor, by the Monte Carlo method.
%
%   Input :
%       Dt              :   step of age
%       npd             :   number of particles
%       f_kf(npd,1)     :   PDF of the input/output process in a reactor
%
%   Output :  
%       f_age(npd,1)   :    PDF of the input/output process in a reactor
% -----------------------------------------------------------------
function con_vcc = Convection(DT,f_kf,np,N_sub)

    % age increment for all particles
    for i = 1:1:np  
        f_age(i,1) = f_kf(i,1) + DT; 
    end
         
    % randomly chooses particles to be reset their age to zero
    for j = 1:1:N_sub  
    
       % randomly chooses a particle from the array of particles
       ip_age = ceil(np*rand(1));
       
       % set particles age to zero
       f_age(ip_age,1)= 0;
    end
    
    % The age PDF value in an input/output process
    con_vcc = f_age;
end
% -----------------------------------------------------------