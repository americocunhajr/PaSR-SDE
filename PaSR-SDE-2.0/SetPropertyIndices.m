% -----------------------------------------------------------------
% SetPropertyIndices
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
function ind_prop = SetPropertyIndices(nindv,ndepv)

    nsv = nindv;
    ndv = ndepv;
    
    % -----------------------------------------------------------------
    %     NUMBER OF PARTICLE PROPERTIES:
    %
    %     nkd = 1 + nsv + ndv
    %
    %     "1"    : particle specific volume (kvol)
    %     nsv    : number of scalar variables (independent)
    %     ndv    : number of dependent variables
    %     nkd    : maximum number of particle properties
    % -----------------------------------------------------------------
    
    nkd = 1 + nsv + ndv;
    
    kf = 1;                 % first scalar property (mixing fraction frequency)
    kl = kf + nsv - 1;      % last scalar property
    kvol = kl + 1;          % specific volume property index
    kdf = kvol + 1;         % first dependent property
    kdl = kdf + ndv - 1;    % last dependent property
    
    ind_prop = [kf,kl,kvol,kdf,kdl,nkd];
    
    % confirm if the nkd-th column of the properties of the function 
    % 'f(npd,nkd)' is equal to the dependent variable last index (kdl)
    if ( nkd ~= kdl )
        fprintf('WARNING!!! The values of nkd = %2i and kdl = %2i are different. \n',nkd,kdl);
        fprintf('See function SET_PROPERTY_INIDCES \n');
        fprintf('\n');
        if (nkd < kdl)
            fprintf('The program has been interrupted!!! \n');
            fprintf('\n');
            return
        end
    end
end
% -----------------------------------------------------------------