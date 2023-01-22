% -----------------------------------------------------------------
% SetPropertyNames
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
function set_prop_nam = ...
             SetPropertyNames(name_indprop,name_depprop,kdl,kvol)

    % loop to determine whether there are dependent variables
    if  (kdl == kvol)
        % create array of independent variables adding the specific volume
        for i_name=1:kvol-1
            iprlab(i_name) = cellstr(name_indprop(i_name));
        end
        % name of specified volume to the ref. variable specified column
        iprlab(kvol) = cellstr('SPEC. VOL.');
    else
        % creates the initial vector of the names of the independent 
        % variables the specific volume  and dependent variables
        iprlab = [name_indprop;cellstr('          ');strcat(name_depprop)];
        % sssigns the name of the specified volume to the specified 
        % column for the referred variable
        iprlab(kvol,1) = cellstr('SPEC. VOL.');
        % transpose the columns vector
        iprlab = iprlab';
    end
    
    % assigns the evaluation variable to the function variable
    set_prop_nam = iprlab;
end
% -----------------------------------------------------------------