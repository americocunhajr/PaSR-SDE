% -----------------------------------------------------------------
% LangevinEI
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This function describes the evolution of the scalar in a 
%  time step according to the Langevin model using the
%  Implicit Euler algorithm (Sabelnikov 2001).
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
%       dW              :   stochastic process
%       d_0             :   constant to be adjusted
%       VarMax          :   maximum variance
%
%   Output :  
%       f_kf(npd,nsv)   :   particle-independent scalars
% -----------------------------------------------------------------
function f_kf = LangevinEI(dt,ncell,omean_cell,...
                           np,npd,nindv,nf,nl,f_kwt,f_kf,...
                           min_mixf,max_mixf,istep,...
                           dW,d_0,VarMax,var_ini)

    % call simulation parameters module
    %ModuleCommonParam;
    
    % loop over the mesh
    for lc = 1:1:ncell
        
        % calculates the total weights in the cell
        sumwt = 0;
        for i = nf(lc):1:nl(lc)
            sumwt = sumwt + f_kwt(i,1);
        end
        if (sumwt <= 0) 
            return
        end
            
        % calculate average turbulent frequency in this cell
        omean = omean_cell(lc);
            
        % Initial value of the sum of c
        sumf = 0;
            
        % Sum the scalars over the particles contained in this cell
        for i = nf(lc):1:nl(lc)
            sumf = sumf + f_kwt(i,1)*f_kf(i,1);
        end
        
        % mean and variance
        fmean = sumf / sumwt;
        fvar = mean( (f_kf(:,1) - fmean ).^2 );
                  
        % Calculate the instantaneous values of c(1-c)
        pq_f = f_kf(:,1).*( 1 - f_kf(:,1) );
                
        % The mean value of <c(c-1)> in each iteration
        pq_f_mean = mean(pq_f(:,1));            
                      
        % Langevin constant a
        a_cte = 1 + d_0*pq_f_mean/VarMax;
            
        % Langevin constant b
        b_cte = d_0*fvar/VarMax;
    
        % loop over the particles in the cell
        for i = nf(lc):1:nl(lc)                 
       
            % LANGEVIN MODEL VIA IMPLICIT EULER METHOD
            
            erro = 1;

            % initial guess
            X = 0.5;
              
            % Newton-Raphson iteration to find f_kf(i,1)
            while ( erro > 1e-8 )
                    
                % range of parameters
                if X < 0
                    X = eps;
                elseif X > 1
                    X = 1-eps;
                end
                
                % compute F(X)
                FX = X + a_cte*omean*( X - fmean )*dt - dW(i,istep)*(2*b_cte*omean*X*(1-X))^half - f_kf(i,1);
                
                % compute D_F(X)
                D_FX = 1 + a_cte*omean*dt - dW(i,istep)*(2*b_cte*omean)^half*(1-2*X)/sqrt(2*X*(1-X));
                 
                % Newton-Raphson iteration
                X_n1 = X - FX/D_FX;
                
                % error estimation
                erro = abs(X_n1 - X);
                
                % update the value
                X = X_n1;
            end
            
            f_kf(i,1) = X;     
        end
    end
end
% -----------------------------------------------------------------