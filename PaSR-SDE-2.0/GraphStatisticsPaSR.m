% -----------------------------------------------------------------
% GraphStatisticsPaSR
% -----------------------------------------------------------------
%  Original code programmer: Elder Marino Mendoza Orbegoso
%  Updated  code programmer: Americo Cunha Jr
%  
%  Originally programmed in: Apr 03, 2007
%            Last update in: Jan 20, 2023
% -----------------------------------------------------------------
% This module plots graphs of the PaSR statistics time evolution.
% -----------------------------------------------------------------

    % mean and variance PDF
    figure(4)
    [AX,H1,H2] = plotyy(estatPASR(1,:),estatPASR(2,:),estatPASR(1,:),estatPASR(3,:),'plot');
    title('PaSR mean and variance evolution','FontSize',12);
    xlabel('t/\tau','FontSize',12);
    set(get(AX(1),'Ylabel'),'String','<\phi>');
    set(get(AX(2),'Ylabel'),'String','\sigma^2');
    
    % 4th and 6th order moments
    figure(5)    % Num_gaf controla o numero de janelas a mostrarem.
    [AX,H1,H2] = plotyy(estatPASR(1,:),estatPASR(5,:),estatPASR(1,:),estatPASR(4,:),'plot');
    title('PaSR fourth and sixth order moments','FontSize',12);
    xlabel('t/\tau','FontSize',12);
    set(get(AX(1),'Ylabel')','String','\mu_6','Color','m');
    set(get(AX(2),'Ylabel') ,'String','\mu_4','Color','r');
    set(H1,'Color','m');
    set(H2,'Color','r');
    set(AX(1),'YColor','m')
    set(AX(2),'YColor','r')
    saveas(gcf,'figure5.png')
% -----------------------------------------------------------------