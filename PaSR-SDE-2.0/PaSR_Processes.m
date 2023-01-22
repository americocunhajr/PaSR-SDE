% -----------------------------------------------------------------
% PaSR_Processes
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This function controls the PaSR processes of input/output,
%  mixture and chemical reactions.
% -----------------------------------------------------------------

istep     = 0;
istep_age = 0;
time      = 0;                          

fprintf('The array of properties "f" in the initial state is stored\n');
fprintf('in the file: EXIT_01\n');
fprintf('\n');

% DETERMINES WHAT TYPES OF PROCESSES MANAGES THE PROGRAM
switch (i_PROC)     
    case (0)    % CONSIDERING A SINGLE PROCESS
        switch(proc_ISO) 
            case (1)    % PURE MIXTURE PROCESS
        
                npd = np;  % max. number of particles =  first dimension 
                           % size of matrix f (usually done for a complete 
                           % simulation of Monte Carlo where the total 
                           % number of particles varies).

                % matrix that stores the evolution of statistical 
                % values as function of time
                estat = zeros(5,nstep+1);

                % initial mean and variance
                media_ini = 0.5*(min_mixf + max_mixf);
                var_ini = mean ( (f_kf(:,1) - media_ini ).^2 );
                
                % statistics of the particles in the initial state
                Statistics;
            
                % random setting for mix model
                if (mixmod == 4)    % SIMPLE LANGEVIN MODEL
                        
                   % Wiener process with 0 mean and variance dt
                   randn('state',100);
                   dW = sqrt(dt)*randn(np,nstep);
                                           
                   % maximum variance
                   VarMax = mean(f_kf(:,1))*( 1 - mean(f_kf(:,1)) );
                   
                   dW_W      = 0;
                   omega_vel = 0;
                   omean_vel = 0;
                   m1        = 0;
                   m2        = 0;
                   XIS       = 0;
                   C_xis     = 0;

               elseif (mixmod == 5)   % EXTENDED IEM MODEL
                
                   % velocity turb. fluctuations variance
                   m2 = 0.29*log(Re_lambda) - 0.36;

                   % velocity turb. fluctuations mean
                   m1 = -m2/2;                       
                        
                   % configure the random field XIS
                   XIS       = RandNormal(np,m1,sqrt(m2));
                   omega_vel = omean_vel*exp(XIS);
                   
                   % Wiener process with 0 mean and variance dt
                   randn('state',50);
                   dW_W = sqrt(dt)*randn(np,nstep);

                   dW  = 0;
                   d_0 = 0;
                    
                   % maximum variance
                   VarMax = mean(f_kf(:,1))*( 1 - mean(f_kf(:,1)) );
                    
               elseif (mixmod == 6)   % EXTENDED LANGEVIN MODEL
                   
                   % Wiener process with 0 mean and variance dt
                   randn('state',100);
                   dW = sqrt(dt)*randn(np,nstep);
                        
                   % maximum variance
                   VarMax = mean(f_kf(:,1))*( 1 - mean(f_kf(:,1)) );       
                   
                   % velocity turb. fluctuations variance
                   m2 = 0.29*log(Re_lambda) - 0.36;

                   % velocity turb. fluctuations mean
                   m1 = -m2/2;
                        
                   % configure the random field XIS
                   XIS       = RandNormal(np,m1,sqrt(m2));
                   omega_vel = omean_vel*exp(XIS);
                                     
                   % Wiener process with 0 mean and variance dt
                   randn('state',50);
                   dW_W = sqrt(dt)*randn(np,nstep);
                            
                else
                   
                    dW        = 0;
                    d_0       = 0;
                    VarMax    = 0;
                    dW_W      = 0;
                    omega_vel = 0;
                    omean_vel = 0;
                    m1        = 0;
                    m2        = 0;
                    XIS       = 0;
                    C_xis     = 0;
                   
                end
              
                % initial PDF
                if (istep == 0)
                        f_f(:,1) = f_kf(:,1);
                end
                
                for i = 1:1:nstep
    
                    fprintf('- Starting the iteration %2i of %2i ... ',i,nstep);
                           
                    % time steps
                    istep = istep + 1;
                    time  = time + dt;
                   
                    % select the mixture model
                    f_kf = MixtureModel(dt,omega,np,npd,nindv,f_kf,...
                                        mixmod,cphi,min_mixf,max_mixf,...
                                        istep,dW,dW_W,d_0,VarMax,...
                                        omega_vel,omean_vel,m1,m2,XIS,...
                                        C_xis,time,var_ini);
    
                    % Calls the function that stores the statistics of 
                    % the mixing models, i.e. calculates the evolution 
                    % of the mean, variance, etc.
                     Statistics;
                    
                    % PDF partial evolution
                    if (istep == 7)
                        f_f(:,2) = f_kf(:,1);
                    elseif (istep == 49)
                        f_f(:,3) = f_kf(:,1);
                    elseif (istep == 70)
                        f_f(:,4) = f_kf(:,1);
                    elseif (istep == 140)
                        f_f(:,5) = f_kf(:,1);
                    end  
                end 
                
            case (2)    % CONSIDERING INPUT/OUTPUT PROCESS
                
                % Choice of N_subs particles to be replaced in I/O process
                N_sub  = ceil(np*DT/tau_res);
                f_unid = zeros(np,1);
                                                                               
                for i = 0:1:nstep_age
    
                    fprintf('Starting the transient iteration %2i of %2i \n',istep_age,nstep_age);
                
                    % function that describes the INPUT/OUTPUT process
                    f_unid  = Convection(DT,f_unid,np,N_sub);
               
                    % time steps
                    istep_age = istep_age + 1;
                    time      = time + dt;
                end
                
                % residence time distribution
                f_kf(:,2) = f_unid;
                  
                
            case (3)    % CONSIDERING REACTION PROCESS

                % progress variable
                c_quim = 0:0.01:1;

                % chemical production
                w_c = Production(c_quim);
        end
         
    % for processes governed by parameters xx, yy and zz
    case (1)    % CONSIDERING COULPED MIXTURE, CONVECTION AND REACTION
        switch (proc_ACO)
            case(1)  % CONSIDERING IEM MIXTURE, CONVECTION AND REACTION

                npd  = np;  % max. number of particles =  first dimension 
                            % size of matrix f (usually done for a complete 
                            % simulation of Monte Carlo where the total 
                            % number of particles varies).
                
                % matrix that stores the evolution of statistical 
                % values as function of time
                estatPASR = zeros(5,nstep_age+1);

                % initial mean and variance
                media_ini = 0.5*(min_mixf + max_mixf);
                var_ini   = mean ( (f_kf(:,1) - media_ini ).^2 );
                
                % statistics of the particles in the initial state
                StatisticsPaSR;
                            
                % chemical time
                Alfa   = (Tad-To)/To;      % reduced chemical heat
                Beta_q = 1000*Ea/(R2*To);  % reduced activation energy (1000 unit convertion)

                W_medio = X_CH4*W_CH4 + X_O2*W_O2; % average molecular weight (kg/kmol)
                Rho     = P_atm/(R1*To);           % density of the mixture at the inlet (kg/m3) where R=0.287 KJ/kgK

                % characteristic time of the chemical reaction
                Tau_quim = (Rho/W_medio*X_CH4*X_O2*Af*exp(-Ea/(R2*To)))^-1;

                % choice of DT time step in the I/O process.
                DT     = N_sub/np;     % Dtau = dt/tau_res (dimensionless)
                f_unid = zeros(np,1);
                                                                               
                % Initial conditions of time variables.
                istep_age = 0;
                time      = 0;
                
                % random configuration for mixing model in REACTIVE case
                if (mixreac == 4)    % REACTIVE LANGEVIN MODEL
                        
                   % Wiener process with 0 mean and variance dt
                   randn('state',100);
                   dW = sqrt(DT)*randn(np,nstep_age);
                                           
                   dW_W  = 0;
                   z     = 0;
                   zz    = 0;
                   m1    = 0;
                   m2    = 0;
                   XIS   = 0;
                   C_xis = 0;

               elseif (mixreac == 5)   % REACTIVE EXTENDED IEM MODEL
                    
                   % velocity turb. fluctuations variance
                   m2 = 0.29*log(Re_lambda) - 0.36;

                    % velocity turb. fluctuations mean
                   m1 = -m2/2;
                        
                   % configure the random field XIS
                   XIS = RandNormal(np,m1,sqrt(m2));
                   z   = zz*exp(XIS);
                                     
                   % Wiener process with 0 mean and variance dt
                   randn('state',80);
                   dW_W = sqrt(DT)*randn(np,nstep_age);
                   
                   dW  = 0;
                   d_0 = 0;
                    
                   % maximum variance
                   VarMax = 0.25;
                    
               elseif (mixreac == 6) % REACTIVE EXTENDED LANGEVIN MODEL
                   
                   % Wiener process with 0 mean and variance dt
                   randn('state',100);
                   dW = sqrt(DT)*randn(np,nstep_age);
                   
                   % velocity turb. fluctuations variance
                   m2 = 0.29*log(Re_lambda) - 0.36;
                   
                   % velocity turb. fluctuations mean
                   m1 = -m2/2;
                        
                   % configure the random field XIS
                   XIS = RandNormal(np,m1,sqrt(m2));
                   z   = zz*exp(XIS);
                                     
                   % Wiener process with 0 mean and variance dt
                   randn('state',90);
                   dW_W = sqrt(DT)*randn(np,nstep_age);

                else
                    
                    dW     = 0;
                    d_0    = 0;
                    VarMax = 0;
                    dW_W   = 0;
                    z      = 0;
                    zz     = 0;
                    m1     = 0;
                    m2     = 0;
                    XIS    = 0;
                    C_xis  = 0;
                end
                
                for i = 1:1:nstep_age
                
                     fprintf('Starting the iteration %2i of %2i ...',i,nstep_age);
    
                    % time steps
                    istep_age = istep_age + 1;
                    time      = time + DT;

                    % INPUT/OUTPUT AND REACTION MIXING PROCESSES
                    
                    % INPUT/OUTPUT and REACTION Mixing Process Function
                    f_kf = ReactionMixture(DT,np,npd,nindv,f_kf,...
                                           mixreac,cphi,min_mixf,max_mixf,...
                                           istep_age,dW,dW_W,d_0,z,m1,m2,...
                                           XIS,C_xis,time,N_sub,rho,...
                                           xx,yy,zz,Beta_q,Alfa,nstep_age);
                    
                    % Calls the function that stores the statistics of 
                    % the mixture models, i.e. calculates the evolution 
                    % of the mean, variance, etc.
                     StatisticsPaSR;
                    
                    % mean PDF
                    if (i>nstep_age-100)
                        StatisticsMeanPDF;
                    end
                end
        end
end
% -----------------------------------------------------------