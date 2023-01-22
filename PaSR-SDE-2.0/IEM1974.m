% -----------------------------------------------------------------
% IEM1974
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This function describes the evolution of the scalar in a 
%  time step according to the interaction by exchange with 
%  the mean (IEM) model.
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
function f_kf = IEM1974(dt,cphi,ncell,omean_cell,...
                        np,npd,nindv,nf,nl,f_kwt,f_kf)

    % call simulation parameters module
    %ModuleCommonParam;
    
    % loop over the domain mesh
    for lc = 1:1:ncell
        
        % compute the total weights on the cell
        sumwt = 0;
        for i = nf(lc):1:nl(lc)
            sumwt = sumwt + f_kwt(i,1);
        end
        if (sumwt <= 0) 
            return
        end
        
        % compute the mean turbulent frequency on this cell
        omean = omean_cell(lc);
        
        % compute the mean decaying rate on this cell
        decay = -cphi*omean*dt;
        
        % Question : Is it 2 the correct factor for the cphi value?
        % Answer   : Yes, the scalar variance reduces to
        %            exp(-cphi*omean-dt), 
        %            therefore the length from the mean decay as
        %            exp(-cphi/2*omean*dt).
        
        % loop over the scalars
        for k = 1:1:nindv
            
            % compute the scalar mean field value on this cell
            sumf = 0;
            
            % sum the scalars over the particles contained in this cell
            for i = nf(lc):1:nl(lc)
                sumf = sumf + f_kwt(i,1)*f_kf(i,k);
            end
            
            fmean = sumf / sumwt;
            
            % second step: compute the step in f
            % physical model: (drop to the cell mean)
            
            % loop over the particles on this cell
            for i = nf(lc):1:nl(lc)
                f_kf(i,k) = f_kf(i,k) + ( f_kf(i,k) - fmean ) * decay;
            end
            
        end
    end
end
% -----------------------------------------------------------------