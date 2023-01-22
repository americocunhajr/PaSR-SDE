% -----------------------------------------------------------------
% RandNormal
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
% This function generates normal distributed random numbers.
% 
%   Input :
%       n           :   quantity of random numbers
%       mu          :   normal distribution mean
%       sigma       :   normal distribution standard deviation
%
%   Output :  
%       rand_normal :   matrix of normal random numbers
% -----------------------------------------------------------------
function rand_normal = RandNormal(n,mu,sigma)

    % pseudo-random numbers generator state
    rand('state',1);
    
    if nargin<3, sigma=1; end
    if nargin<2, mu=0; end
    if nargin<1, n=1; end
    if size(n)==1
       n = [n 1];
       if size(mu,2)>1, mu = mu'; end
       if size(sigma,2)>1, sigma = sigma'; end
    end
    
    rand_normal = randn(n).*sigma + mu;
end
% -----------------------------------------------------------------