% -----------------------------------------------------------------
% MonteCarlo
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This function initiates the stochastic simulation, initiating 
%  and ordering the matrix f properties.
% -----------------------------------------------------------------
function ini_mc = MonteCarlo(i_PROC,proc_ISO,proc_ACO,np,nkd,nindv,kf)
    
    % load input variables
    PaSR_Data
    
    % matrix f
    f_int = zeros(np,nkd);
    
    % Up to this point, only the independent escorts have been 
    % initialized, now it only remains to initialize the dependent 
    % scalars if applicable
    switch (i_PROC)
        
        case(0) % One single process
            
            switch (proc_ISO)
                
                case (1)        % pure mixture

                    % Assigns the values of independent properties, 
                    % depending on the case to be studied.
                    f_int = InitParticleProperties(f_int,np,nkd,nindv,kf); 
                    kvol = nindv + 1;       % index where the specific volume is rented.
                    relvol = 1;             % relative volume equal to ONE
                    relvol_init = 1;        % initial relative volume
                    v_i = 1/rho;            % specific volume v_i
                    for i = 1:1:np
                        f_int(i,kvol) = v_i;
                    end

                    %     RELATIVE VOLUME REPRESENTED BY PARTICLES
                    %
                    %     revol :
                    %       It is assumed that each particle "i" has a unitary mass
                    %       m_i = 1 the volume represented by a particle and then the
                    %       specific volume:
                    %          v_i = m_i / rho_i = 1 / rho_i = f(i,kvol)
                    %
                    %       The total relative volume represented by the particles is:
                    %          relvol = SUM ( f(i,kvol) )
                    %       This volume can change due to mixing.
                    %
                    %     revol_init :
                    %       initial value of revol
                    
                case (2)    % pure convection

                    % assign the AGE values to all particles equals zero
                    f_int = f_int;          % f_int e considered as the AGE distance
                    kvol = nindv + 1;       % index where the specific volume is rented.
                    relvol = 1;             % relative volume equal to ONE
                    relvol_init = 1;        % initial relative volume
                    v_i = 1/rho;            % specific volume v_i
                    for i = 1:1:np
                        f_int(i,kvol) = v_i;
                    end
                    
                case (3)    % simple radiation 1st order

                    f_int = InitParticleProperties(f_int,np,nkd,nindv,kf); 
                    kvol = nindv + 1;       % index where the specific volume is rented.
                    relvol = 1;             % relative volume equal to ONE
                    relvol_init = 1;        % initial relative volume
                    v_i = 1/rho;            % specific volume v_i
                    for i = 1:1:np
                        f_int(i,kvol) = v_i;
                    end
                    
            end
                           
        case(1) % coupled convection, mixture and reaction
            
            switch (proc_ACO)
                case (1)   % coupled processes with IEM mixture model

                    % assign the AGE values to all particles equals zero
                    f_int = InitParticleProperties(f_int,np,nkd,nindv,kf); 
                    kvol = nindv + 1;       % index where the specific volume is rented.
                    relvol = 1;             % relative volume equal to ONE
                    relvol_init = 1;        % initial relative volume
                    v_i = 1/rho;            % specific volume v_i
                    for i = 1:1:np
                        f_int(i,kvol) = v_i;
                    end

                case (2)    % Considerando os processsos acoplados com mistura ???.

                    fprintf('WARNING!!! The chosen case is not yet implemented... ');
                    fprintf('See function MonteCarlo \n');
                    fprintf('The program has been interrupted!!! \n');
                    fprintf('\n');
                    return

                case (3)    % Considerando os processsos acoplados com mistura ???.

                    fprintf('WARNING!!! The chosen case is not yet implemented... ');
                    fprintf('See function MonteCarlo \n');
                    fprintf('The program has been interrupted!!! \n');
                    fprintf('\n');
                    return 

                otherwise
                    
                    fprintf('WARNING!!! The chosen case is not yet implemented... ');
                    fprintf('See function MonteCarlo \n');
                    fprintf('The program has been interrupted!!! \n');
                    fprintf('\n');
                    return 
            end   
               
        otherwise
            
            fprintf('WARNING!!! The chosen case is not yet implemented... ');
            fprintf('See function MonteCarlo \n');
            fprintf('The program has been interrupted!!! \n');
            fprintf('\n');
            return 
    end       
    
    % Returns the 'f' matrix with pre-established values
    % For the respective mixture calculation
    ini_mc = f_int; 
end
% -----------------------------------------------------------------


% -----------------------------------------------------------------
% InitParticleProperties
% -----------------------------------------------------------------
% This subroutine does the initialization of particle properties.
% Entrada :
%           np          :   number of particles
%           nkd         :   number of particles properties
%           nindv       :   number of independent scalars
%           kf          :   firt index (mixture fraction)
%
% entrada / Saida:
%           f(npd,nkd)  :   matrix containing the particles properties
%----------------------------------------------------------------------    
function initpp = InitParticleProperties(f_int,np,nkd,nindv,kf,kvol)
    
    % call simulation parameters module
    %ModuleCommonParam;
    
    % load input variables
    PaSR_Data
    
    % Three possibilities:   a. One peak
    %                        b. Two equal peaks
    %                        c. Beta PDF BETA for mixture fraction

    % This subroutine is developed just for the case when an 
    % independent scalar (mixing fraction) is considered
    if (nindv > 2)
        fprintf('WARNING!!! You have to modify the function InitParticleProperties, \n ');
        fprintf('Initialization of was done for TWO independent scalars. \n ');
        fprintf('See function MonteCarlo \n');
        fprintf('The program has been interrupted!!! \n');
        fprintf('\n');
        return
    end
    
    switch (initscal)
        
        % Case 'a': one peak
        case(0)
            
            init_mixf = 0; 
            
            for i = 1:1:np
                f_int(i,kf) = init_mixf;
            end
            
        % Case 'b': two peaks
        case (1)
            
            mean_mixf = 0.5*(min_mixf + max_mixf);
            
            half_np = np/2;
            if (2*half_np ~= np)
                fprintf('WARNING!!! To initialize the two equal peaks, we need\n ');
                fprintf('of an even number of particles. \n');
                fprintf('The program has been interrupted!!! \n');
                fprintf('\n');
                return
            end
            
            for i = 1:1:half_np
                f_int(i,kf) = min_mixf;
            end
            
            for i = half_np+1:1:np
                f_int(i,kf) = max_mixf;
            end
            
        % Case 'c': Beta PDF
        case(2)
                   
            % max variance  
            var_max = med_mixf * ( 1 - med_mixf );

            % min variance
            var_min = 0.00025;
            
            if (var_mixf < var_min || var_mixf > var_max)
                fprintf('WARNING!!! The variance that you provided for the Beta function does not comply with the limits \n');
                fprintf('The program has been interrupted!!! \n');
                fprintf('\n');  
                return
            end
            
            % beta distribution parameters
            aa = med_mixf * med_mixf * (one - med_mixf) / var_mixf - med_mixf;
            bb = aa * (1 / med_mixf - 1);
            
            % np random number with beta distribution
            f_int(:,kf) = RandBeta(np,aa,bb);
    end
    
    initpp = f_int;
end
% -----------------------------------------------------------------