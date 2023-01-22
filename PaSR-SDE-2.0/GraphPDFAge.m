% -----------------------------------------------------------------
% GraphPDFAge
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
% This module plots graphs of a scalar PDF.
% -----------------------------------------------------------------
          
    % residence time PDF
    num_interv = 20;
    
    max_age = max(f_kf(:,2));
    
    D_int = (max_age - 0)/num_interv;
    
    sum_age = zeros(1,num_interv);
    
    alpha = zeros(1,num_interv);
    
    domin = half*D_int:D_int:max_age-half*D_int;
    frequen=zeros(1,length(domin));
    
    for j=1:1:length(domin)   
        for i=1:1:np
            if  f_kf(i,2)>=(j-1)*D_int && f_kf(i,2)<=(j)*D_int
                frequen(1,j)=frequen(1,j)+1;
            end
        end
    end
    
    % Age PDF obtained by Monte Carlo
    figure(6)
    plot(domin,frequen,'or','MarkerFaceColor','y','MarkerSize',5);
    title('Number of Particles as a function of their Age','FontSize',12);
    xlabel('\alpha'     ,'FontSize',12);
    ylabel('n_p(\alpha)','FontSize',12);
    saveas(gcf,'figure6.png')
    
    % dimensionless value
    PDF_age = frequen/(np*D_int);
    
    % Analytical solution
    Alpha_an   = 0:max_age/40:max_age;
    P_alpha_an = exp(-Alpha_an/tau_res)/tau_res;
    
    figure(7)
    plot(domin,PDF_age      ,'or',...
         Alpha_an,P_alpha_an,'b',...
         'MarkerFaceColor','y','MarkerSize',5);
    title('Age PDF'   ,'FontSize',12);
    xlabel('\alpha'   ,'FontSize',12);
    ylabel('P(\alpha)','FontSize',12);
    saveas(gcf,'figure7.png')
    
    % Analytical and numerical solution age-normalized PDF
    figure(8)
    plot(domin/tau_res,PDF_age*tau_res      ,'or',...
         Alpha_an/tau_res,P_alpha_an*tau_res,'b',...
         'MarkerFaceColor','y','MarkerSize',5);
    title('Age normalized PDF'     ,'FontSize',12);
    xlabel('\alpha / \tau_r_e_s'   ,'FontSize',12);
    ylabel('P(\alpha) * \tau_r_e_s','FontSize',12);
    saveas(gcf,'figure8.png')
    
    % Analytical and numerical solution age-normalized PDF
    figure(9)
    semilogy(domin/tau_res,PDF_age*tau_res      ,'or',...
             Alpha_an/tau_res,P_alpha_an*tau_res,'b',...
             'MarkerFaceColor','y','MarkerSize',5);
    title('Age normalized PDF'     ,'FontSize',12);
    xlabel('\alpha / \tau_r_e_s'   ,'FontSize',12);
    ylabel('P(\alpha) * \tau_r_e_s','FontSize',12);
    saveas(gcf,'figure9.png')
% -----------------------------------------------------------------