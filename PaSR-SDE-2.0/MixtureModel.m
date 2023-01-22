% -----------------------------------------------------------------
% MixtureModel
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This function controls the scalar relaxation for ONE TIME STEP
%  according to the designated mixture model.
%   
%       0 - no mixing 
%       1 - IEM
%       2 - Coalescence Dispersion
%       3 - Modified Curl
%       4 - Langevin 
%       5 - Extended IEM
%       6 - Extended Langevin
% -----------------------------------------------------------------
function Modo_Mistura = MixtureModel(dt,omega,np,npd,nindv,f_kf,...
                                     mixmod,cphi,min_mixf,max_mixf,...
                                     istep,dW,dW_W,d_0,VarMax,...
                                     omega_vel,omean_vel,m1,m2,XIS,...
                                     C_xis,time,var_ini)

    ncell = 1;
    nf(1) = 1;
    nl(1) = np;
    omean_cell(1) = omega;
    for i = 1:1:np
        f_kwt(i,1) = 1;       % todas as particulas tem a mesma massa.
    end
    
    % chose between the implemented mixing models
    switch mixmod
        
        case (0)
            return
            
        case (1)
            fprintf('calling the model IEM (reactive case) \n');
            Modo_Mistura = IEM1974(dt,cphi,ncell,omean_cell,...
                                   np,npd,nindv,nf,nl,f_kwt,f_kf);
              
        case (2)
            fprintf('calling the model Coalescence Redispersion (reactive case) \n');
            Modo_Mistura = CD1982(dt,cphi,ncell,omean_cell,...
                                  np,npd,nindv,nf,nl,f_kwt,f_kf);
            
        case (3)
            fprintf('calling the model Modified Curl (reactive case) \n');
            Modo_Mistura = MC1978(dt,cphi,ncell,omean_cell,...
                                  np,npd,nindv,nf,nl,f_kwt,f_kf);
            
        case (4)
            fprintf('calling the model Langevin (reactive case) \n');
            Modo_Mistura = Langevin_MT(dt,ncell,omean_cell,...
                                       np,npd,nindv,nf,nl,f_kwt,f_kf,...
                                       min_mixf,max_mixf,istep,...
                                       dW,d_0,VarMax,var_ini);

        case (5)
            fprintf('calling the model Extended IEM (reactive case) \n');
            Modo_Mistura = ExtIEM_MT(dt,ncell,omean_cell,...
                                     np,npd,nindv,nf,nl,f_kwt,f_kf,...
                                     min_mixf,max_mixf,istep,...
                                     dW_W,VarMax,omega_vel,omean_vel,...
                                     m1,m2,XIS,C_xis,time);
            
        case (6)
            fprintf('calling the model Extended Langevin (reactive case) \n');
            Modo_Mistura = ExtLangevin_MT(dt,ncell,omean_cell,...
                                          np,npd,nindv,nf,nl,f_kwt,f_kf,...
                                          min_mixf,max_mixf,istep,...
                                          dW_W,VarMax,omega_vel,omean_vel,...
                                          m1,m2,XIS,C_xis,d_0,dW,...
                                          time,var_ini);
        
        otherwise
            fprintf('Illegal value found in mixmod =%5.2f \n ',mixmod);
            fprintf('\n');
            return
    end
end
% -----------------------------------------------------------