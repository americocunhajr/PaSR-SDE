% -----------------------------------------------------------------
% StatisticsPDF
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
% This module shows the PDF in graphic form
% -----------------------------------------------------------------

    % load input variables
    PaSR_Data;
    
    % number of intervals to split
    num_interv = 30;    
    
    % interval value
    D_int = (max_mixf - min_mixf)/num_interv;
    
    % PDF support
    domin = min_mixf:D_int:max_mixf;    

    % frequency value divided in numint+1 parts
    frequen = zeros(1,length(domin));
    
    % initial PDF
    for j=1:1:length(domin)
        for i=1:1:np
            if  f_kf(i,1)>=min_mixf+((j-1)-half)*D_int && f_kf(i,1)<min_mixf+((j-1)+half)*D_int
                frequen(1,j)=frequen(1,j)+1; 
            end   
        end
    end
    
    % dimensionless value
    freq = frequen*num_interv/np; % normalized PDF int(freq d alpha = 1).
    
    % scalar PDF graph
    figure(3)
    plot(domin,freq,'b-',domin,freq,'r.');
    title('passive scalar normalized PDF','FontSize',12);
    xlabel('\psi','FontSize',12);
    ylabel('f_\phi (\psi)','FontSize',12);
% -----------------------------------------------------------------