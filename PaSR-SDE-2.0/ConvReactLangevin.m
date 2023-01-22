% -----------------------------------------------------------------
% ConvReactLangevin
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This function simulates input/output Langevin mixing processes
%  and reaction of the particles contained in a PaSR reactor 
%  by the method of Monte Carlo.
% -----------------------------------------------------------------
function cnv_3LANGEVIN_rc = ConvReactLangevin(DT,f_kf,np,N_sub,cphi,...
                                              rho,xx,yy,Beta_q,Alfa,...
                                              min_mixf,max_mixf,...
                                              istep_age,dW,d_0)

    % call simulation parameters module
    %ModuleCommonParam;

     % mean and variance of the scalars over the contained particles
     fmean = mean(f_kf(:,1));
     fvar = mean( (f_kf(:,1) - fmean ).^2 );
     
     % maximum variance
     VarMax = 0.25;
    
     % instantaneous values of c(1-c)
     pq_f = f_kf(:,1).*( 1 - f_kf(:,1) );
                
     % mean value of <c(c-1)> at each iteration
     pq_f_mean = mean(pq_f(:,1));            
                      
     % Langevin constant a
     a_cte = 1 + d_0*pq_f_mean/(eps+VarMax);
            
     % Langevin constant b
     b_cte = d_0*fvar/(eps+VarMax);
     
    % age increase for each time step
    for i = 1:1:np  
            
            % age increase
            f_kf(i,2) = f_kf(i,2) + DT;
       
            % REACTIVE LANGEVIN MODEL BY THE IMPLICIT MILSTAIN TAYLOR METHOD
            
            erro = 1;
            
            % interval of parameters
            Xa = 0;  Xb =1;
              
            % find the value f_kf(i,1) by bissection method
            while ( erro > 1e-7 )
                  
                % calculation of the functions F(X) and F(Xb)
                FXa =  Xa + a_cte*xx*( Xa - fmean )*DT - yy*(1-Xa)*DT*exp(Beta_q*Xa/(Xa+1/Alfa)) - dW(i,istep_age)*(2*b_cte*xx*Xa*(1-Xa))^(0.5)+ (0.5)*b_cte*xx*(1-2*Xa)*(dW(i,istep_age)^2+DT) - f_kf(i,1);
                FXb =  Xb + a_cte*xx*( Xb - fmean )*DT - yy*(1-Xb)*DT*exp(Beta_q*Xb/(Xb+1/Alfa)) - dW(i,istep_age)*(2*b_cte*xx*Xb*(1-Xb))^(0.5)+ (0.5)*b_cte*xx*(1-2*Xb)*(dW(i,istep_age)^2+DT) - f_kf(i,1);
                
                % calculation of  Xc
                Xc = (Xa+Xb)/2;
                
                % calculation of F(Xc)
                FXc =  Xc + a_cte*xx*( Xc - fmean )*DT - yy*(1-Xc)*DT*exp(Beta_q*Xc/(Xc+1/Alfa)) - dW(i,istep_age)*(2*b_cte*xx*Xc*(1-Xc))^(0.5)+ (0.5)*b_cte*xx*(1-2*Xc)*(dW(i,istep_age)^2+DT) - f_kf(i,1);
    
                % decide
                if (FXa*FXc > 0)
                    Xa = Xc;
                else
                    Xb = Xc;
                end
                
                % final error
                erro = abs(Xa - Xb);
                
                % update the value
                X = Xc;
            end
            
            f_kf(i,1) = X;
    end  
    
    % randomly chooses the particles to be reset their age to zero
    for j = 1:1:N_sub  
    
           % randomly chooses a particle from the array of particles
           ip_age = ceil(np*rand(1));
            
           % RESET THE PROGRESS VARIABLE AT THE PARTICLE ENTRY TO ZERO
           f_kf(ip_age,1)= 0;
           
           % RESET THE AGE OF THE CHOSEN PARTICLES TO ZERO
           f_kf(ip_age,2)= 0;
    end
    
    % age PDF value in an input/output process
    cnv_3LANGEVIN_rc = f_kf;  
end
% -----------------------------------------------------------------