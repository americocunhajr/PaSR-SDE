% -----------------------------------------------------------------
% InitLookupSize
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This function returns the name of independent (nindv) 
%  and dependent (ndepv) scalars. It returns [nindv,ndepv].
% -----------------------------------------------------------------
function ind_dep = InitLookupSize(i_PROC,proc_ISO,proc_ACO)

    ind_dep = [0,0];

    switch i_PROC
    
    % single process case
    case (0)
        switch  proc_ISO
            case (1)    % pure mixture process
                nindv = 2;
                ndepv = 0;
            case (2)    % pure convection process
                nindv = 2;
                ndepv = 0;
            case (3)    % simple first order reaction process
                nindv = 2;
                ndepv = 0;
            otherwise
                fprintf('WARNING!!! The chosen case is not yet implemented... ');
                fprintf('See function INIT_LOOKUP \n');
                fprintf('The program has been interrupted!!! \n');
                fprintf('\n');
                return
        end
    
    % coupled processes case
    case (1)    
        switch  proc_ACO
            case (1)    % coupled processes with IEM model
                nindv = 2;
                ndepv = 0;
            case (2)
                fprintf('WARNING!!! The chosen case is not yet implemented... ');
                fprintf('See function INIT_LOOKUP \n');
                fprintf('The program has been interrupted!!! \n');
                fprintf('\n');
                return
            case (3)
                fprintf('WARNING!!! The chosen case is not yet implemented... ');
                fprintf('See function INIT_LOOKUP \n');
                fprintf('The program has been interrupted!!! \n');
                fprintf('\n');
                return
            otherwise
                fprintf('WARNING!!! The chosen case is not yet implemented... ');
                fprintf('See function INIT_LOOKUP \n');
                fprintf('The program has been interrupted!!! \n');
                fprintf('\n');
            return
        end
                 
    otherwise
        fprintf('WARNING!!! The LOOKUP method is not known... ');
        fprintf('See function INIT_LOOKUP \n');
        fprintf('The program has been interrupted!!! \n');
        fprintf('\n');
        return 
        
    end

 ind_dep = [nindv,ndepv];
end
% -----------------------------------------------------------------