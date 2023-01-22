% -----------------------------------------------------------------
% EswaranPope1988
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
function tax_dis = EswaranPope1988(time,omean_vel)

    omegat = time*omean_vel;
    
    tax_dis = 10.5*exp(-0.12*omegat.^2+0.050.*omegat);
end
% -----------------------------------------------------------------