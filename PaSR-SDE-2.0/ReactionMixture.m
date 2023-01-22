% -----------------------------------------------------------------
% ReactionMixture
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This function controls the PaSR evolution for ONE TIME STEP
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
function Modo_Reativo = ReactionMixture(DT,np,npd,nindv,f_kf,...
                                        mixreac,cphi,min_mixf,max_mixf,...
                                        istep_age,dW,dW_W,d_0,z,m1,m2,...
                                        XIS,C_xis,time,N_sub,rho,...
                                        xx,yy,zz,Beta_q,Alfa,nstep_age)

    
    ncell = 1;
    nf(1) = 1;
    nl(1) = np;
    for i = 1:1:np
        f_kwt(i,1) = 1;
    end
    
    % chose between the implemented mixing models
    switch mixreac
        
        case (0)
            return
            
        case (1)
            fprintf('calling the model IEM (reactive case) \n');
            Modo_Reativo = ConvReactIEM(DT,f_kf,np,N_sub,cphi,...
                                        rho,xx,yy,Beta_q,Alfa);
              
        case (2)
            fprintf('calling the model Coalescence Redispersion (reactive case) \n');
            % Not implemented
            
        case (3)
            fprintf('calling the model Modified Curl (reactive case) \n');
            % Not implemented
            
        case (4)
            fprintf('calling the model Langevin (reactive case) \n');
            Modo_Reativo = ConvReactLangevin(DT,f_kf,np,N_sub,cphi,...
                                             rho,xx,yy,Beta_q,Alfa,...
                                             min_mixf,max_mixf,...
                                             istep_age,dW,d_0);
            
        case (5)
            fprintf('calling the model Extended IEM (reactive case) \n');
            Modo_Reativo = ConvReactExtIEM(DT,f_kf,np,N_sub,cphi,...
                                           rho,zz,yy,xx,Beta_q,Alfa,...
                                           dW_W,z,m1,m2,XIS,C_xis,istep_age);
        
        case (6)
            fprintf('calling the model Extended Langevin (reactive case) \n');
            Modo_Reativo = ConvReactExtLangevin(DT,f_kf,np,N_sub,cphi,...
                                                rho,zz,yy,xx,Beta_q,Alfa,...
                                                min_mixf,max_mixf,...
                                                istep_age,dW,d_0,dW_W,...
                                                z,m1,m2,XIS,C_xis); 
        
        otherwise
            fprintf('Illegal value found in mixmod =%5.2f \n ',mixmod);
            fprintf('\n');
            return
    end
end
% -----------------------------------------------------------