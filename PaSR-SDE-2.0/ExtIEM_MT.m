% -----------------------------------------------------------------
% ExtIEM_MT
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This function describes the evolution of the scalar in a 
%  time step according to the extended IEM model using the
%  Milstein-Taylor implicit algorithm (Sabelnikov 2001).
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
function f_kf = ExtIEM_MT(dt,ncell,omean_cell,...
                          np,npd,nindv,nf,nl,f_kwt,f_kf,...
                          min_mixf,max_mixf,istep,...
                          dW_W,VarMax,omega_vel,omean_vel,...
                          m1,m2,XIS,C_xis,time)

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
        
        % constant value
        OMEGAO = omean*fvar/( mean(omega_vel.*f_kf(:,1).^2)-mean(f_kf(:,1)*mean(omega_vel.*f_kf(:,1))) );
        
        % loop over the particles in the cell
        for i = nf(lc):1:nl(lc)                 
       
            % Milstain Taylor implicit method for XIS
            XIS(i) = ( XIS(i) + C_xis*omean_vel*m1*dt + sqrt(2*m2*C_xis*omean_vel)*dW_W(i,istep) ) / (1 + C_xis*omean_vel*dt);
            
            % lognormal didstribution of velocities fluctuations
            omega_vel(i) = omean_vel*exp(XIS(i));
            
            new_value = - OMEGAO*omega_vel(i)*( f_kf(i,1) - mean(f_kf(:,1).*omega_vel)/mean(omega_vel) )*dt;
                
            f_kf(i,1) = f_kf(i,1) + new_value;
        end     
    end
end
% -----------------------------------------------------------------