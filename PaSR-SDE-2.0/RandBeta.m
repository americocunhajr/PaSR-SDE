% -----------------------------------------------------------------
% RandBeta
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
% This function generates beta distributed random numbers.
% 
%   Input:
%       n           :   quantity of random numbers
%       a           :   beta distribution mean
%       b           :   beta distribution variance 
%
%   Output:  
%       rand_beta   :   matrix of beta random numbers
% -----------------------------------------------------------------
function rand_beta = RandBeta(n,mu,sigma)

    % pseudo-random numbers generator state
    rand('state',2);
    
    if any(any((mu<=0)|(sigma<=0)))
       error('The mean values and variance are negative');
    end
    
    if size(n)==1
       n = [n 1];
    end
    
    rand_beta = INV_BETA(rand(n),mu,sigma);
end
% -----------------------------------------------------------------

% -----------------------------------------------------------------
% INV_BETA
% -----------------------------------------------------------------
%   Input :
%       p           :   matrix to find the beta distribution inverse
%       a           :   alpha value
%       b           :   beta value
%
%   Output :  
%       beta_inver  :   matrix for the beta distribution inverse
% -----------------------------------------------------------------
function beta_inver = INV_BETA(p,a,b)

    % restricts to positive alpha and beta values
    if any(any((a<=0)|(b<=0)))
       error('The mean values and variance are negative')
    end
    if any(any(abs(2*p-1)>1))
       error('The probability must be 0<=p<=1 !')
    end
    
    b = min(b,100000);
    
    % mean calculation
    beta_inver = a ./ (a+b);
    
    dx = 1;
    
    while any(any(abs(dx)>256*eps*max(beta_inver,1)))
       dx = (betainc(beta_inver,a,b) - p) ./ DIST_BETA(beta_inver,a,b);
       beta_inver = beta_inver - dx;
       beta_inver = beta_inver + (dx - beta_inver) / 2 .* (beta_inver<0);
       beta_inver = beta_inver + (1 + (dx - beta_inver)) / 2 .* (beta_inver>1);
    end
end
% -----------------------------------------------------------------

% -----------------------------------------------------------------
% DIST_BETA
% -----------------------------------------------------------------
%   Input :
%       x           :   matrix of numbers
%       a           :   alpha value
%       b           :   beta value
%
%   Output :  
%       beta_d      :   beta-type PDF numbers
% -----------------------------------------------------------------
function beta_d = DIST_BETA(x,a,b)

    % restricts to positive alpha and beta values
    if any(any((a<=0)|(b<=0)))
       error('Parameters a and b are negative')
    end
    
    % indices which do not fulfill the support condition [0,1]
    I = find( ( x < 0)|( x > 1 ) );
    
    % beta distribution value
    beta_d = x.^(a-1) .* (1-x).^(b-1) ./ beta(a,b);
    
    % filtering out the spurious values
    beta_d(I) = 0*I;
end
% -----------------------------------------------------------------