function out = plot_filter_salinity_MOSAiC()
%PLOT_FILTER_SALINITY_MOSAIC - plots for paper
%
%   filter data (ASAL, psu by MacFarlane et al., 2022 on PANGEA)

%   Plot snow salinities of snowpack on sea ice
%    a. snow height vs salinity Sp
%    b. PDF of salinity Sp 
%    c. accumulated PDF of salinity Sp
%
%    MF Grenoble, 01.02.2019

clear; clc;
close('all');
pth = '../../';
fname = sprintf('%sMOSAiC_snowpits_13_salinity.mat',pth);
load(fname)
openfig ./temp_salinity.fig;
h = get(gcf,'Children');

%% filter data
X = Sp;
Xfilt = Sp; 
% use only BSn season (Oct 2019 - May 2020)
t1 = datenum('15-Oct-2019');
t2 = datenum('15-May-2020');
n = find(utc>t2);
Xfilt(n) = NaN;
% exclude the bottom layer (= sea ice or refrozen brine) z_med<=0.015
% n = find(z_med<=0.015);
n = find(z_med<=0.005);
Xfilt(n) = NaN;

out = [prctile(Xfilt,[25 50 75]) nansum(isfinite(Xfilt)) nansum(isfinite(X))];
%***********************************************************************************************
%% PANEL A. snow height vs salinity
set(gcf,'CurrentAxes',h(3));
p1 = semilogx(X,z_med.*100,'ko','MarkerSize',6, 'MarkerFaceColor','k'); % psu
hold on; grid on;
p2 = semilogx(Xfilt,z_med.*100,'ko','MarkerSize',6, 'MarkerFaceColor','y'); % psu

l1 = hline(0,'k'); set(l1,'Color','k','LineWidth',2,'LineStyle','-');
l2 = vline(35.165,'k'); set(l2,'LineStyle','--','LineWidth',2);

lg1 = legend([p1 p2],'all data','filtered data','Location','North','Orientation','horizontal','box','off');
set(lg1,...
    'Position',[0.0827749528447884 0.709578089668934 0.252089136490251 0.0351084923279529],...
    'Orientation','horizontal',...
    'FontSize',18);

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
h1 = histogram(Xfilt,'DisplayStyle','bar','FaceColor','y',...
    'EdgeColor','k','LineWidth',1);
h1.BinEdges = binedges_log'; % 5 bins per order of magnitude
h1.Normalization = 'probability';
hold on; grid on;
h2 = histogram(X,'DisplayStyle','stairs','EdgeColor','b','LineWidth',2);
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
legend('filtered','all','Location','NorthEast');

%***********************************************************************************************
%% PANEL C. accumulated PDF of salinity Sp
set(gcf,'CurrentAxes',h(1));
l3 = cdfplot(Xfilt); set(l3,'Color','k','LineWidth',2);
hold on; grid on;
l4 = cdfplot(X); set(l4,'Color','b','LineWidth',2);

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
legend('filtered','all','Location','SouthEast');


%***********************************************************************************************
h = get(gcf,'children'); % get axes handles
set(h,'FontSize',18,'FontName','Times');
set(0,'defaultaxeslinewidth',2); set(0,'defaultlinelinewidth',1); 
set(gcf, 'Color', [1,1,1]); % white background
%***********************************************************************************************
% best quality w/ transparent area with
% export_fig 'fig_salinity.pdf' '-pdf' '-painters' '-r864';
