% -----------------------------------------------------------------
% InitLookup
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
%  This function returns the name of independent (name_indprop) 
%  and dependent (name_deprop) scalars, generates a cross reference
%  table, signs 'rho' index of the density in the arrangement of 
%  the dependent variables.
% -----------------------------------------------------------------
function [name_indpropx,name_deppropx] = ...
               InitLookup(i_PROC,proc_ISO,proc_ACO,nindv,ndepv)

    switch (i_PROC)
    
    % single process case
    case (0)    
        switch (proc_ISO)    
            case(1) % pure mixture process
                name_indpropx = [cellstr('MIX. FRAC.'),cellstr('AGE     ')];
                name_deppropx = cellstr('          ') ;
            case(2) % pure convection process
                name_indpropx = [cellstr('MIX. FRAC.'),cellstr('AGE     ')];
                name_deppropx = cellstr('          ');
            case(3) % simple first order reaction process
                name_indpropx = [cellstr('MIX. FRAC.'),cellstr('AGE     ')];
                name_deppropx = cellstr('          ');
                return
            otherwise
                fprintf('WARNING!!! The chosen case is not yet implemented... ');
                fprintf('See function INIT_LOOKUP \n');
                fprintf('The program has been interrupted!!! \n');
                fprintf('\n');
                return        
        end

    % coupled processes case
    case (1)
        
        switch (proc_ACO)
            case(1) % coupled processes with IEM model
                name_indpropx = [cellstr('MIX. FRAC.'),cellstr('AGE     ')];
                name_deppropx =  '          ';
            case(2)
                fprintf('WARNING!!! The chosen case is not yet implemented... ');
                fprintf('See function INIT_LOOKUP \n');
                fprintf('The program has been interrupted!!! \n');
                fprintf('\n');
                return     
            case(3)
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
end
% -----------------------------------------------------------------