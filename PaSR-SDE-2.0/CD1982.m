% -----------------------------------------------------------------
% CD1982
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This function describes the evolution of the scalar in a 
%  time step according to the coalescence and dispersion 
%  (C/D) model.
%
%   Input :
%       dt              :   time step
%       cphi            :   IEM model constant
%       ncell           :   number of cells in the domain
%       omean_cell(l)   :   mean turbulent frequency in cell l
%       np              :   number of particles
%       npd             :   first dimension of array f
%       nsv             :   number of independent scalars
%       nf(l)           :   first particle in the cell (l)
%       nl(l)           :   last  particle in the cell (l)
%       f_kwt(np)       :   particle weights
%       f_kf(npd,nsv)   :   particle-independent scalars
%
%   Output :  
%       f_kf(npd,nsv)   :   particle-independent scalars
% -----------------------------------------------------------------
function f_kf = CD1982(dt,cphi,ncell,omean_cell,...
                       np,npd,nindv,nf,nl,f_kwt,f_kf)

    % call simulation parameters module
    %ModuleCommonParam;
    
    % loop over the mesh
    for lc = 1:1:ncell
        
        % number of particles in the mesh
        totnum = nl(lc) - nf(lc) + 1;
        
        % --- check the number of particles ---
        % No mixing occurs if
        % totnum = 0 (empty mesh) or 
        % totnum = 1 (only one particle)
        if (totnum == 0 || totnum == 1)
            continue    % continue to the next iteration
        end
        
        % compute the mean frequency on the mesh
        omean = omean_cell(lc);
        Beta = 2;   % Beta = 2 (Curl model)
        
        % compute the number of particle pairs 
        % which mix with the same probability
        mixnum = Beta * ceil(dt*omean*np); 
        
        % loop over the mixture
        for  j = 1:1:mixnum
            
            % Create a pair of particles and calculate the 
            % mixing probability for this pair
            while i<10000000
                ip = ceil(np*rand(1)); % select the ip-th particle
                iq = ceil(np*rand(1)); % select the iq-th particle
                Part_A = f_kf(ip,1);
                Part_B = f_kf(iq,1);
                if Part_A ~= Part_B 
                    break 
                end
            end 
            
            for k = 1:1:nindv
                   % mixture happens
                   newscv = 0.5.*( Part_A + Part_B ); 
                   f_kf(ip,k) = newscv;
                   f_kf(iq,k) = newscv;
            end    
        end
    end
end
% -----------------------------------------------------------------