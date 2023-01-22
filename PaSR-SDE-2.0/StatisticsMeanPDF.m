% -----------------------------------------------------------------
% StatisticsMeanPDF
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
% This module compute the PDF matrix in the last 100 iterations 
% and cumputes the PDF mean (in the reactive case).
% -----------------------------------------------------------------
    
    % number of intervals to split
    num_interv = 30;
    
    % interval value
    D_int = (max_mixf - min_mixf)/num_interv;
    
    % PDF support
    domin = min_mixf+0.5*D_int:D_int:max_mixf-0.5*D_int;

    % frequency value divided in numint parts
    frequen=zeros(5,length(domin));
    
    % initial PDF
    for j=1:1:length(domin)
        for k=1:1:np
            if  f_kf(k,1)>=min_mixf+(j-1)*D_int && f_kf(k,1)<min_mixf+(j)*D_int
                frequen(1,j)=frequen(1,j)+1;
            end   
        end
    end
    
    % dimensionless value
    freq = frequen*num_interv/np; % normalized PDF int(freq d alpha = 1).
    
    % stores all frequencies obtained in time in a matrix form
    if  (i == nstep_age-99)
        FREQU = freq(1,:);   % first frequency
    else
        FREQU = [FREQU;freq(1,:)];
    end
    
    if (i == nstep_age)
        
        % mean frequency
        freq_media=mean(FREQU);
        
        % mean graph for the reactive case
        figure(20)
        plot(domin,freq_media(1,:),'b-',domin,freq_media,'r.');
        title('passive scalar normalized PDF','FontSize',12);
        xlabel('\psi','FontSize',12);
        ylabel('f_\phi (\psi)','FontSize',12);
    end
% -----------------------------------------------------------------