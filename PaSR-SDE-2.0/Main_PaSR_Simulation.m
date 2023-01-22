% -----------------------------------------------------------------
% Main_PaSR_Simulation
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This script if the main file for a program that evaluate
%  several mixture model for combustion simulation.
% -----------------------------------------------------------------


clc
clear
close all


% program execution start time
% ----------------------------------------------------------------
timeStart = tic();
% ----------------------------------------------------------------


% program header
% -----------------------------------------------------------
disp('                                                     ')
disp(' =================================================== ')
disp(' Partially Stirred Reactor (PaSR) Simulation         ')
disp('                                                     ')
disp(' by                                                  ')
disp(' Elder Marino Mendoza Orbegoso                       ')
disp(' Americo Cunha Jr                                    ')
disp(' =================================================== ')
disp('                                                     ')
% -----------------------------------------------------------


% call simulation parameters module
%ModuleCommonParam;


% READING AND VERIFICATION OF INPUT VARIABLES
% -----------------------------------------------------------
fprintf('\n');
fprintf(' ------------------------------------------- \n');
fprintf(' READING OF INPUT VARIABLES                  \n');
fprintf(' ------------------------------------------- \n');
fprintf(' \n');

i_PROC = -1;        % number of processes to be studied
nstep  = -1;        % number of iterations
dt     = -1.0;      % time step

% load input variables
PaSR_Data

% array of variables
nam_var = {'np',...
           'rho',...
           'initscal',...
           'min_mixf',...
           'max_mixf',...
           'med_mixf',...
           'var_mixf',...
           'omega',...
           'nstep',...
           'dt',...
           'mixmod',...
           'cphi',...
           'i_PROC', ...
           'proc_ISO',...
           'proc_ACO'};

% check the existence of the variables
var_exist = ismember(nam_var,who);

if var_exist == ones(1,length(var_exist))
    fprintf('READY!!! Input variables have been loaded successfully. \n');
else
    fprintf('PROBLEM!!! More variables needed, please review \n');
    for i = 1:1:length(var_exist)
        if var_exist(1,i)==0
            fprintf('......review the %2i-th variable:', i ); 
            disp( nam_var(1,i) );
            fprintf('The program has been interrupted!!! \n');
            fprintf('\n');
        end
    end
    return
end
% -----------------------------------------------------------


% check the input variables coherence
% ------------------------------------------------------
fprintf('\n');
fprintf(' ------------------------------------------- \n');
fprintf(' VERIFYING THE COHERENCE OF THE INPUT DATA   \n');
fprintf(' ------------------------------------------- \n');
fprintf(' \n');

% returns a vector indicating the number of errors and warnings
chk_inp = CheckInput(np,rho,initscal,i_PROC,proc_ISO,proc_ACO,...
                                        nstep,dt,mixmod,cphi,omega);

% treatment of the CheckInput function results
if (chk_inp == zeros(1,2))
    fprintf('READY!!! The input variables showed no errors. \n');
else
    fprintf('PROBLEM!!! %2i errors e %2i warnings were displayed. \n',chk_inp(1),chk_inp(2));
    fprintf('The program has been interrupted!!! \n');
    fprintf('\n');
    return
end
% ------------------------------------------------------


% define independent and dependent properties
% ------------------------------------------------------
fprintf('\n');
fprintf(' ------------------------------------------- \n');
fprintf(' DEFINE INDEPENDENT AND DEPENDENT PROPERTIES \n');
fprintf(' ------------------------------------------- \n');
fprintf(' \n');

% arrangement of dependent and independent variables
ind_dep = InitLookupSize(i_PROC,proc_ISO,proc_ACO);

% assigns numeric values to independent and dependent variables
nindv = ind_dep(1);  % independent variables
ndepv = ind_dep(2);  % dependent   variables

fprintf('READY!!! Number of dependent and independent properties defined. \n');
fprintf('\n');

% arrangement of indices of the properties of function 'f'
ind_prop = SetPropertyIndices(nindv,ndepv);

% indices of dependent and independent properties
kf   = ind_prop(1);   % first scalar property (mixing fraction frequency)
kl   = ind_prop(2);   % last scalar property
kvol = ind_prop(3);   % specific volume property index
kdf  = ind_prop(4);   % first dependent property
kdl  = ind_prop(5);   % last dependent property
nkd  = ind_prop(6);   % maximum number of properties

fprintf('READY!!! Dependent and independent properties successfully indexed. \n');
fprintf('\n');

% arrays of dependent and independent property names.
[name_indprop,name_depprop] = InitLookup(i_PROC,proc_ISO,proc_ACO,nindv,ndepv);

% assigns the property names to the PDF array (main array)
set_prop_nam = SetPropertyNames(name_indprop,name_depprop,kdl,kvol);

fprintf('READY!!! Independent and dependent properties have names. \n');
fprintf('\n');
% ------------------------------------------------------


% Monte Carlo simulation
% ------------------------------------------------------
fprintf('\n');
fprintf(' ------------------------------------------- \n');
fprintf(' CALLING MONTE CARLO FUNCTION                \n');
fprintf(' ------------------------------------------- \n');
fprintf('\n');

% calling Monte Carlo function and storing it in the variable 'f kf'
f_kf = MonteCarlo(i_PROC,proc_ISO,proc_ACO,np,nkd,nindv,kf);

fprintf('READY!!! Array "f" created successfully. \n');
fprintf('\n');
% ------------------------------------------------------


% loop over the mixture models
% ------------------------------------------------------
fprintf('\n');
fprintf(' ------------------------------------------- \n');
fprintf(' CALLING PaSR PROCESSES FUNCTION             \n');
fprintf(' ------------------------------------------- \n');
fprintf('\n');

% calling the function that controls all processes
PaSR_Processes;

fprintf('\n');
fprintf('READY!!! The program successfully processed the data. \n');
fprintf('\n');
% ------------------------------------------------------


% output data and figures
% ------------------------------------------------------
switch (i_PROC)
    case (0)
        switch (proc_ISO)
            case (1)
                % call graphical routines
                GraphPDFMix;
                GraphStatistics;
                
                % create variables to be exported to Tecplot
                  pdf_T = [domin;freq]';
                estat_T = estat';
                 
                % save datasets
                save('1pdfs.dat',  'pdf_T','-ascii');
                save('2evol.dat','estat_T','-ascii');
            case (2)
                % PDF of residency time
                GraphPDFAge; 
            case (3)
                % chemical production
                plot(c_quim,w_c); 
        end
    case (1)
        switch (proc_ACO)
            case (1)               
                % call graphical routines
                %GraphPDFAge;
                GraphPDFPaSR;
                GraphStatisticsPaSR;
                
                % create variables to be exported to Tecplot
                  pdf_T = [domin;freq]';
                estat_T = estatPASR';
                  pdf_T = [domin;freq_media]';
                 
                % save datasets
                save('1pdfs.dat',   'pdf_T','-ascii');
                save('2evol.dat', 'estat_T','-ascii');
                save('1pdfMed.dat', 'pdf_T','-ascii');
        end
end
% ------------------------------------------------------


% program execution time
% ------------------------------------------------------
disp(' ');
disp(' -----------------------------');
disp('            THE END!          ');
disp(' -----------------------------');
disp('  Total execution time:       ');
disp(['  ',num2str(toc(timeStart)),' seconds']);
disp(' -----------------------------');
% ------------------------------------------------------