% -----------------------------------------------------------------
% PaSR_DATA
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
% This module has the input data for the PaSR simulation
% -----------------------------------------------------------------

    % ......................................................
    % particles
    % ......................................................
    np = 4^7; % number of particles
    rho = 1; % density of it particle (may be variable)

                     % independent scalars
    initscal =  0;   % 0 - one peak : min_mixf (for PaSR).
                     % 1 - two equal : min_mixf and max_mixf.
                     % 2 - beta distribution

    min_mixf =  0;   % 1st peak of the mixture fraction (initscal = 1)
    max_mixf =  1;   % 2nd peak of the mixture fraction (initscal = 1)
    
    med_mixf = 0.5;  % beta distribution mean (initscal = 1 e 2)
    var_mixf = 0.15; % beta distribution variance (initscal = 2)


    % ......................................................
    % iterations
    % ......................................................
    nstep = 500;    % number of iterations (multiple of 4)
    dt    = 1.0e-4; % mixture time step
    
    
    % ......................................................
    % simulation type (LOOKUP)
    % ...................................................... 
    i_PROC = 1;   % Considered case:
                  % 0 - considers the evaluation of an isolated process (default)
                  % 1 - Evaluation of coupled mixing and convection and reaction processes
                        
    proc_ISO = 1; % Case of a single process:
                  % 1 - pure mixture
                  % 2 - pure convection
                  % 3 - pure reaction
       
    proc_ACO = 1; % Case of two processes:
                  % 1 - Mixing and convection and reaction processes (default)
    
    
    % ......................................................
    % mixture initial stage
    % ......................................................
    mixmod = 6;   % mixture models for non-reactive cases
                  %   0 - no mixture
                  %   1 - IEM
                  %   2 - coalescence and dispersion (C/D)
                  %   3 - modified Curl (MC)
                  %   4 - Langevin (LM)
                  %   5 - extented IEM (EIEM)
                  %   6 - extened Langevin (ELM)
       
    omega = 100;  % mean turbulence scalar frequency
    cphi  = 1.0;  % variance decay rate for IEM model (default value = 1)
    d_0   = 1.0;  % constant d_0 to adjust (LM and ELM)
             
                      % parameters for EIEM and ELM models
    C_xis     = 1.6;  % fixed constant
    Re_lambda = 50;   % Reynolds number at Taylor scale
    omean_vel = 100;  % mean valocity turbulent frequency
    

    % ......................................................
    % reactor parameters
    % ......................................................
    mixreac = 4;   % mixture models for reactive cases
                   %   0 - no mixture
                   %   1 - IEM
                   %   2 - coalescence and dispersion (C/D)
                   %   3 - modified Curl (MC)
                   %   4 - Langevin (LM)
                   %   5 - extented IEM (EIEM)
                   %   6 - extened Langevin (ELM)
    
    To       = 300;           % fresh gases temperature in the reactor input (K)
    P_atm    = 101.325;       % atmospheric pressure (kPa)
    R1       = 0.287;         % perfect gases universal constant (kJ/kg.K)
    rho_inic = P_atm/(R1*To); % input mixture initial density (kg/m3)
    
    % Processo de entrada do Reator inerte SO CONVECCAO.
    %--------------------------------------------------
    V       = 0.25;             % reactor volume (m^3)
    m_dot   = 0.45;             % fresh mixture mass flow (kg/s)
    tau_res = rho_inic*V/m_dot; % mean residence time (s)
                                % (only for non-reactive convection)

    N_sub     = 4^3;  % number of particles to be replaced in the reactor
    nstep_age = 2500; % number of iteration (min of 2000 for steady state)
                
                % relation parameters for the PaSR time-scales
    xx = 2;     % partially considered
    yy = 0.034; % partially considered
    zz = 2;     % for extended cases
    
    
    % ......................................................
    % thermochemical properties
    % ......................................................
    R2    = 2.0;      % perfect gases universal constant (kcal/kmol.k)
    Tad   = 540;      % adiabatic flame temperature (K)
    Ea    = 9;        % activation energy (kcal/mol)
    Af    = 1.3*10^9; % pre-exponential coefficient
    X_CH4 = 1/3;      % methane molar fraction
    X_O2  = 2/3;      % oxygen  molar fraction
    W_CH4 = 16;       % methane molecular weight (kg/kmol)
    W_O2  = 32;       % oxygen  molecular weight (kg/kmol)

% -----------------------------------------------------------------