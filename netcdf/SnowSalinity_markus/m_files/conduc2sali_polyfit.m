function [P,S,PSU] = conduc2sali_polyfit()
%conduc2sali_polyfit - compute salinity based on measured conductivity 
%   compute salinity (psu) from observed conductivity (mS/cm) based on 5th
%   order polynomial fit
%
%   MF Cambridge, 25/11/2016
%   update: Cambridge, 13/10/2017

% clear;                 % clear variables and
% close('all');          % ...close figures
% based on final data set in SNOW_blowsea.xls
fname = '~/Documents/research/Antarctica/BLOWSEA/DATA/SNOW/data/SNOW_stats.mat';
load(fname)

% 1) Derive polynomial fit to psu vs. mS/cm based on all salinity
% measurements (N=252)
n = find(isfinite(mS_psu_all(:,1)));
cond = mS_psu_all(n,1);
psu = mS_psu_all(n,2);
[P,S] = polyfit(cond,psu,5);
P(end) = 0; % force through origin (e.g. cv_RMSE of 0.0275 instead of 0.0261)
psu_interp = polyval(P,cond);
S.rmse = sqrt(sum((psu-psu_interp).^2)./length(psu));
S.cv_rmse = S.rmse./nanmean(psu);


% 2) Compute salinity (psu) based on measured salinity value (mS/cm)
x = linspace(0,60,1000);
y = polyval(P,x);
PSU = polyval(P,mS_psu_all(:,1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLOTTING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
subplot(1,2,1)
plot(x,y,'m-','LineWidth',2);
hold on; grid on;
plot(cond,psu,'bo','MarkerSize',8);
set(gca,'Xlim',[0 65],'YLim',[0 45]);
title('Snow on Sea Ice - Weddell Sea 2013','FontName','Times','FontSize',24);
xlabel('salinity (mS/cm)','FontName','Times','FontSize',20);
ylabel('salinity (psu)','FontName','Times','FontSize',20);
legend('5th order polynom','All observations (N=252)','Location','NorthWest');

set(gca,'FontSize',18,'FontName','Times');
set(0,'defaultaxeslinewidth',2); set(0,'defaultlinelinewidth',1); 

subplot(1,2,2)
plot(x,y,'m-','LineWidth',2);
hold on; grid on;
plot(cond,psu,'bo','MarkerSize',8);
set(gca,'Xlim',[-0.01 0.5],'YLim',[-0.01 0.25],'YAxisLocation','right');
% title('Snow on Sea Ice - Weddell Sea 2013','FontName','Times','FontSize',24);
xlabel('salinity (mS/cm)','FontName','Times','FontSize',20);
ylabel('salinity (psu)','FontName','Times','FontSize',20,...
'Rotation',270,'VerticalAlignment','bottom');

set(gca,'FontSize',18,'FontName','Times');
set(0,'defaultaxeslinewidth',2); set(0,'defaultlinelinewidth',1); 
