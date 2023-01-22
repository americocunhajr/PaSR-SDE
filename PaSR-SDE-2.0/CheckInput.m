% -----------------------------------------------------------------
% CheckInput
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
% This function verifies if input data is correct.
% -----------------------------------------------------------------
function chk_inp = CheckInput(np,rho,initscal,i_PROC,proc_ISO,...
                                 proc_ACO,nstep,dt,mixmod,cphi,omega)

    nerr = 0;       % Variable that counts the number of errors
    nwar = 0;       % Variable that counts the number of warnings
    
    
    % Checking the number of particles
    if (np <= 0)
        fprintf('ERROR!!! np <= 0 \n ');
        nerr = nerr + 1;
    end
    
    % Checking the density value
    if (rho <= 0 )
        fprintf('ERROR!!! rho <= 0 \n ');
        nerr = nerr + 1;
    end
    
    % Checking the initial PDF type
    if (initscal < 0 || initscal > 2)
        fprintf('ERROR!!! initsac = inteiro [0,2] \n ');
        nerr = nerr + 1;
    end
    
    % Tipo de proceso.
    % ---------------
    if (i_PROC < 0 || i_PROC > 2)
        fprintf('ERROR!!! i_PROC = inteiro [0,2] \n ');
        nerr = nerr + 1;
    end
    
    if (proc_ISO < 1 || proc_ISO > 3)
        fprintf('ERROR!!! ilut < 0 \n ');
        nerr = nerr + 1;
    end
    
    if (proc_ACO < 1 || proc_ACO > 1)
        fprintf('ERROR!!! ilut < 0 \n ');
        nerr = nerr + 1;
    end
    
    % number of iterations
    if (nstep < 0)
        fprintf('ERROR!!! nstep < 0 \n ');
        nerr = nerr + 1;
    end
    
    % time step
    if (dt <= 0)
        fprintf('ERROR!!! dt <= 0 \n ');
        nerr = nerr + 1;
    end
    
    % mixture
    if (mixmod < 0 || mixmod > 6)
        fprintf('ERROR!!! mixmod <> 0 - 6 \n ');
        nerr = nerr + 1;
    end
    
    % mixture model constants
    if (cphi < 0)
    fprintf('ERROR!!! cphi < 0 \n ');
        nerr = nerr + 1;
    elseif (abs(cphi)-2 >= 1e-6)
        fprintf('WARNING!!! ABS(cphi - 2.0) >= 1E-6 \n ');
        nwar = nwar + 1;
    end
    
    if (omega < 0)
    fprintf('ERROR!!! omega < 0 \n ');
        nerr = nerr + 1;
    end
    
    % output results
    chk_inp = [nerr,nwar];
% -----------------------------------------------------------------