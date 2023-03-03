function plot_salinity_blowsea()
%PLOT_SALINITY_BLOWSEA - plots for paper
%    Plot snow salinities of snowpack on sea ice
%    a. snow height vs salinity Sp
%    b. PDF of salinity Sp 
%    c. accumulated PDF of salinity Sp
%
%    MF Grenoble, 01.02.2019

clear; clc;
close('all');
% pth = '~/Documents/research/Antarctica/BLOWSEA/DATA/SNOW/data/';
pth = '../../';
fname = sprintf('%sSNOW_stats_blowsea.mat',pth);
load(fname)
openfig ./temp_salinity.fig;
h = get(gcf,'Children');

%% separate FYI (17/6-25/7) and MYI (26/07 -5/08)
t0 = datenum('26-July-2013');
n1 = find(all_snow(:,1)<t0);
n2 = find(all_snow(:,1)>=t0);
n3 = find(all_ice(:,1)<t0);
n4 = find(all_ice(:,1)>=t0);
n5 = find(all_BSn(:,1)<t0);
n6 = find(all_BSn(:,1)>=t0);

%***********************************************************************************************
%% PANEL A. snow height vs salinity
set(gcf,'CurrentAxes',h(3));
p1 = semilogx(all_snow(n1,9),all_snow(n1,2),'ko','MarkerSize',6, 'MarkerFaceColor','y'); % psu-gsw
hold on; grid on;
p2 = semilogx(all_snow(n2,9),all_snow(n2,2),'ko','MarkerSize',6, 'MarkerFaceColor','b'); % psu-gsw
p3 = semilogx(all_snow(n1,9),all_snow(n1,2),'ko','MarkerSize',6, 'MarkerFaceColor','y'); % psu-gsw
p4 = semilogx(all_ice(n3,9),all_ice(n3,2).*0-5,'k^','MarkerSize',9, 'MarkerFaceColor','y'); % psu-gsw
semilogx(all_ice(n4,9),all_ice(n4,2).*0-5,'k^','MarkerSize',9, 'MarkerFaceColor','b'); % psu-gsw
p5 = semilogx(all_BSn(n5,9),all_BSn(n5,2).*0+105,'ks','MarkerSize',9, 'MarkerFaceColor','y'); % psu-gsw
semilogx(all_BSn(n6,9),all_BSn(n6,2).*0+105,'ks','MarkerSize',9, 'MarkerFaceColor','b'); % psu-gsw

l1 = hline(0,'k'); set(l1,'Color','k','LineWidth',2,'LineStyle','-');
l2 = vline(35.165,'k'); set(l2,'LineStyle','--','LineWidth',2);

lg1 = legend([p1 p2 p3 p4 p5],'FYI','MYI','snow','ice','BSn','Location','North','Orientation','horizontal','box','off');
set(lg1,...
    'Position',[0.0827749528447884 0.709578089668934 0.252089136490251 0.0351084923279529],...
    'Orientation','horizontal',...
    'FontSize',18);

% hh = herrorbar(19.4691,0,11.8009,'sb'); % mean+-1std of all sea ice surface scrapes (N=16)
% set(hh,'MarkerSize',16, 'MarkerFaceColor','b','LineWidth',3);
xl = {'10^{-4}' '10^{-3}' '10^{-2}' '10^{-1}' '10^{0}' '10^{1}' '10^{2}'};
set(gca,'XLim',[0 100],'XGrid','on','GridLineStyle','-',...
    'XTick',[1e-4 1e-3 1e-2 1e-1 1 10 100],'XTickLabel',xl,...
    'YLim',[-10 110],'LineWidth',2);
xlabel('S_p (psu)');
ylabel('snow layer height above ice (cm)');

% Create textbox
annotation(gcf,'textbox',...
    [0.107948852874585 0.665520242154931 0.032058492688414 0.0352220520673812],...
    'String',{'a.'},...
    'LineStyle','none',...
    'FontSize',20,...
    'FontName','Times New Roman',...
    'FitBoxToText','off');
annotation(gcf,'textbox',...
    [0.280844541977208 0.654093531241026 0.0484379520304725 0.0357735723771577],...
    'String','RSW',...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman',...
    'FitBoxToText','off');

%***********************************************************************************************
%% PANEL B. PDF of salinity Sp
set(gcf,'CurrentAxes',h(2));
h1 = histogram(all_snow(n1,9),'DisplayStyle','bar','FaceColor','y',...
    'EdgeColor','k','LineWidth',1);
h1.BinEdges = binedges_log'; % 5 bins per order of magnitude
h1.Normalization = 'probability';
hold on; grid on;
h2 = histogram(all_snow(n2,9),'DisplayStyle','stairs','EdgeColor','b','LineWidth',2);
h2.BinEdges = binedges_log'; % 5 bins per order of magnitude
h2.Normalization = 'probability';

xl = {'10^{-4}' '10^{-3}' '10^{-2}' '10^{-1}' '10^{0}' '10^{1}' '10^{2}'};
set(gca,'XLim',[0 100],'YLim',[0 0.2],'XScale','log',...
    'XTick',[1e-4 1e-3 1e-2 1e-1 1 10 100],'XTickLabel',xl);
xlabel('S_p (psu)');
ylabel('probability','Rotation',90,'VerticalAlignment','bottom');

annotation(gcf,'textbox',...
    [0.389893297319029 0.658229841182877 0.0320584926884139 0.0352220520673812],...
    'String','b.',...
    'LineStyle','none',...
    'FontSize',20,...
    'FontName','Times New Roman',...
    'FitBoxToText','off');
legend('FYI','MYI','Location','NorthEast');

%***********************************************************************************************
%% PANEL C. accumulated PDF of salinity Sp
set(gcf,'CurrentAxes',h(1));
l3 = cdfplot(all_snow(n1,9)); set(l3,'Color','k','LineWidth',2);
hold on; grid on;
l4 = cdfplot(all_snow(n2,9)); set(l4,'Color','b','LineWidth',2);

set(gca,'XScale','log',...
        'XTick',[1e-4 1e-3 1e-2 1e-1 1 10 100],'XTickLabel',xl,...
        'YLim',[0 1],'YAxisLocation','right');
xlabel('S_p (psu)');
ylabel('cumulative probability','Rotation',270,'VerticalAlignment','bottom');
title('');
annotation(gcf,'textbox',...
    [0.677393297319029 0.658229841182876 0.0320584926884139 0.0352220520673812],...
    'String','c.',...
    'LineStyle','none',...
    'FontSize',20,...
    'FontName','Times New Roman',...
    'FitBoxToText','off');
legend('FYI','MYI','Location','SouthEast');


%***********************************************************************************************
h = get(gcf,'children'); % get axes handles
set(h,'FontSize',18,'FontName','Times');
set(0,'defaultaxeslinewidth',2); set(0,'defaultlinelinewidth',1); 
set(gcf, 'Color', [1,1,1]); % white background
%***********************************************************************************************
% best quality w/ transparent area with
% export_fig 'fig_salinity.pdf' '-pdf' '-painters' '-r864';
