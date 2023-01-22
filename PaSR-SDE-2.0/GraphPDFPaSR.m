% -----------------------------------------------------------------
% GraphPDFPaSR
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
% This module plots graphs of a scalar PDF.
% -----------------------------------------------------------------

    num_interv = 30;
    
    D_int = (max_mixf - min_mixf)/num_interv;
    
    domin = min_mixf+0.5*D_int:D_int:max_mixf-0.5*D_int;
    frequen=zeros(5,length(domin));
    
    for j=1:1:length(domin)
        for i=1:1:np
            if  f_kf(i,1)>=min_mixf+(j-1)*D_int && f_kf(i,1)<min_mixf+(j)*D_int
                frequen(1,j)=frequen(1,j)+1;
            end
        end
    end
    
    
    % dimensionless value
    freq = frequen*num_interv/np;
    
    % initial scalar PDF
    figure(10)
    plot(domin,freq(1,:),'b-',domin,freq(1,:),'r.');
    title('passive scalar normalized PDF','FontSize',12);
    xlabel('\psi'         ,'FontSize',12);
    ylabel('f_\phi (\psi)','FontSize',12);
    saveas(gcf,'figure10.png')
% -----------------------------------------------------------------