% -----------------------------------------------------------------
% ExtLangevin_EM
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This function describes the evolution of the scalar in a 
%  time step according to the extended Langevin model using the
%  Euler-Maruyama algorithm (Sabelnikov 2001).
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
function f_kf = ExtLangevin_EM(dt,ncell,omean_cell,...
                               np,npd,nindv,nf,nl,f_kwt,f_kf,...
                               min_mixf,max_mixf,istep,...
                               dW_W,VarMax,omega_vel,omean_vel,...
                               m1,m2,XIS,C_xis,d_0,dW,time,var_ini)

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
        pq_f = f_kf(:,1).*( 1 - f_kf(:,1) );  % O vetor de c(c-1) em cada iteracao.
                
        % The conditioned mean value of  <c(c-1) | w > = <c(c-1)w>/<w> in each iteration
        pq_f_mean = mean(pq_f(:,1).*omega_vel)/mean(omega_vel);            
                      
        % Langevin constant a
        a_cte = 1 + d_0*pq_f_mean/VarMax;
            
        % Langevin constant b
        b_cte = (d_0/VarMax)*(mean(f_kf(:,1).^2.*omega_vel)-mean(f_kf(:,1).*mean(f_kf(:,1).*omega_vel)))/(mean(omega_vel));
        
        % constant value
        OMEGAO = omean*fvar/( mean(omega_vel.*f_kf(:,1).^2)-mean(f_kf(:,1)*mean(omega_vel.*f_kf(:,1))) );  
        
        % loop over the particles in the cell
        for i = nf(lc):1:nl(lc)
            
            % Euler-Maruyama method for XIS
            XIS(i) = XIS(i) - ( XIS(i) - m1)*C_xis*omean_vel*dt + sqrt(2*m2*C_xis*omean_vel)*dW_W(i,istep);
            
            % lognormal didstribution of velocities fluctuations
            omega_vel(i) = omean_vel*exp(XIS(i));
            
            new_value = - OMEGAO*omega_vel(i)*( f_kf(i,1) - mean(f_kf(:,1).*omega_vel)/mean(omega_vel) )*dt + dW(i,istep)*(2*b_cte*OMEGAO*omega_vel(i)*pq_f(i,1))^half;
                
            f_kf(i,1) = f_kf(i,1) + new_value;
        end
    end
end
% -----------------------------------------------------------------