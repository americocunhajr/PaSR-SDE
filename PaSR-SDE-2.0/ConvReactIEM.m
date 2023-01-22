% -----------------------------------------------------------------
% ConvReactIEM
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This function simulates input/output IEM mixing processes
%  and reaction of the particles contained in a PaSR reactor
%  by the method of Monte Carlo.
% -----------------------------------------------------------------
function cnv_IEM_rc = ConvReactIEM(DT,f_kf,np,N_sub,...
                                      cphi,rho,xx,yy,Beta_q,Alfa)

    
    % call simulation parameters module
    %ModuleCommonParam;
    
    % Average of the scalars over the contained particles
    fmean = mean(f_kf(:,1));
    
    % age increase for each time step
    for i = 1:1:np  

            % age increase
            f_kf(i,2) = f_kf(i,2) + DT;
       
            % REACTIVE EMI MODEL BY IMPLIED EULER METHOD
            
            erro = 1;
            
            % interval of parameters
            Xa = 0;  Xb =1;
              
            % find the value f_kf(i,1) by bissection method
            while ( erro > 1e-7 )
                  
                % calculation of the functions F(X) and F(Xb)
                FXa =  Xa + xx*( Xa - fmean )*DT - yy*(1-Xa)*DT*exp(Beta_q*Xa/(Xa+1/Alfa)) - f_kf(i,1);
                FXb =  Xb + xx*( Xb - fmean )*DT - yy*(1-Xb)*DT*exp(Beta_q*Xb/(Xb+1/Alfa)) - f_kf(i,1);
                
                % calculation of  Xc
                Xc = (Xa+Xb)/2;
                
                % calculation of F(Xc)
                FXc =  Xc + xx*( Xc - fmean )*DT + - yy*(1-Xc)*DT*exp(Beta_q*Xc/(Xc+1/Alfa)) + - f_kf(i,1);
    
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
    cnv_IEM_rc = f_kf;
end
% -----------------------------------------------------------------