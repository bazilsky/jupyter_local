% plot_frequency
%
% Plot distributions of salinity & DF in ice, snow, and air
%
% MF Cambridge, 10.05.2015
% update: Cambridge, 13/10/2017

clear; clc;
% close('all');
fname = '../data/SNOW_stats_blowsea.mat';
load(fname)

% (a) Salinity of all snow samples (pit and BSn)- interpolated psu
figure
subplot(1,2,1)
h2 = histogram(psu_interp_all);
h2.BinEdges = binedges_log';
h2.Normalization = 'probability';
hold on; grid on;

set(gca,'XLim',[0 60],'YLim',[0 0.2]);
set(gca,'XScale','log');
xlabel('salinity (psu)');
ylabel('frequency');
title('Snow on Sea Ice - Weddell Sea 2013');
legend('all observations (N=213)');

subplot(1,2,2)
h2 = histogram(psu_interp_10cm);
h2.BinEdges = binedges_log';
h2.Normalization = 'probability';
hold on; grid on;

set(gca,'XLim',[0 60],'YLim',[0 0.2]);
set(gca,'XScale','log');
xlabel('salinity (psu)');
ylabel('frequency');
title('Snow on Sea Ice - Weddell Sea 2013');
legend('top 10cm (N=101)');

% Salinity of Snow Pack (mS/cm)
% subplot(1,2,1)
% h4 = histogram(snowpack_all(:,5));
% h4.BinWidth = 0.05;
% h4.Normalization = 'probability';
% hold on; grid on;
% % h5 = histogram(snowpack_all(:,5));
% % h5.BinWidth = 0.05;
% % h5.Normalization = 'probability';
% set(gca,'XLim',[0 5]);
% xlabel('sal (mS/cm)');
% title('All (N=213)');
% legend('All');
% 
% subplot(1,2,2)
% h4 = histogram(snowpack_10cm(:,5));
% h4.BinWidth = 0.05;
% h4.Normalization = 'probability';
% hold on; grid on;
% % h5 = histogram(snowpack_all(:,5));
% % h5.BinWidth = 0.05;
% % h5.Normalization = 'probability';
% set(gca,'XLim',[0 5]);
% xlabel('sal (mS/cm)');
% title('Top 10cm (N=101)');
% legend('10cm');

% (a) Snow Depth
% subplot(1,3,1)
% h1 = histogram(snow_depth/100);
% h1.BinWidth = 0.05;
% h1.Normalization = 'probability';
% grid on;
% set(gca,'XLim',[0 1]);
% xlabel('Snow Depth (m)');
% title('N=24');

%***********************************************************************************************
h = get(gcf,'children'); % get axes handles
set(h,'FontSize',16,'FontName','Times');
set(0,'defaultaxeslinewidth',1); set(0,'defaultlinelinewidth',1); 



