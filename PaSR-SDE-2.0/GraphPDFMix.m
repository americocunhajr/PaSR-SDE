% -----------------------------------------------------------------
% GraphPDFMix
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

    domin = min_mixf:D_int:max_mixf;
    frequen=zeros(5,length(domin));
    
    for j=1:1:length(domin)
        
        for i=1:1:np
            if  f_f(i,1)>=min_mixf+((j-1)-half)*D_int & f_f(i,1)<min_mixf+((j-1)+half)*D_int
                frequen(1,j)=frequen(1,j)+1;
            end   
            
            if  f_f(i,2)>=min_mixf+((j-1)-half)*D_int & f_f(i,2)<min_mixf+((j-1)+half)*D_int
                frequen(2,j)=frequen(2,j)+1;
            end  
            
            if  f_f(i,3)>=min_mixf+((j-1)-half)*D_int & f_f(i,3)<min_mixf+((j-1)+half)*D_int
                frequen(3,j)=frequen(3,j)+1;
            end  
            
            if  f_f(i,4)>=min_mixf+((j-1)-half)*D_int & f_f(i,4)<min_mixf+((j-1)+half)*D_int
                frequen(4,j)=frequen(4,j)+1;
            end  
            
            if  f_f(i,5)>=min_mixf+((j-1)-half)*D_int & f_f(i,5)<min_mixf+((j-1)+half)*D_int
                frequen(5,j)=frequen(5,j)+1;
            end
        end
    end
    
    
    % dimensionless value
    freq = frequen*num_interv/np;
    
    % initial PDF
    figure(1)
    plot(domin,freq(1,:),'b-',domin,freq(1,:),'r.');
    title('Passive scalar normalized PDF','FontSize',12);
    xlabel('\psi'         ,'FontSize',12);
    ylabel('f_\phi (\psi)','FontSize',12);
    saveas(gcf,'figure1.png')
    
    % PDF evolution
    figure(2)
    subplot(2,2,1); plot(domin,freq(2,:),'b-',domin,freq(2,:),'r.');
    title('Passive scalar normalized PDF','FontSize',10);
    xlabel('\psi'         ,'FontSize',10); 
    ylabel('f_\phi (\psi)','FontSize',10);
    
    subplot(2,2,2); plot(domin,freq(3,:),'b-',domin,freq(3,:),'r.');
    title('Passive scalar normalized PDF','FontSize',10);
    xlabel('\psi'         ,'FontSize',10); 
    ylabel('f_\phi (\psi)','FontSize',10);

    subplot(2,2,3); plot(domin,freq(4,:),'b-',domin,freq(4,:),'r.');
    title('Passive scalar normalized PDF','FontSize',10);
    xlabel('\psi'         ,'FontSize',10); 
    ylabel('f_\phi (\psi)','FontSize',10);

    subplot(2,2,4); plot(domin,freq(5,:),'b-',domin,freq(5,:),'r.');
    title('Passive scalar normalized PDF','FontSize',10);
    xlabel('\psi'         ,'FontSize',10); 
    ylabel('f_\phi (\psi)','FontSize',10);
    saveas(gcf,'figure2.png')

    figure(3)
    plot(domin,freq(5,:),'b-',domin,freq(5,:),'r.');
    title('Passive scalar normalized PDF','FontSize',12);
    xlabel('\psi'         ,'FontSize',12);
    ylabel('f_\phi (\psi)','FontSize',12);
    saveas(gcf,'figure3.png')
% -----------------------------------------------------------------