README MOSAiC Snow Salinity

Citation:
Macfarlane, Amy R; Schneebeli, Martin; Dadic, Ruzica; Wagner, David N; Arndt, Stefanie; Clemens-Sewall, David; Hämmerle, Stefan; Hannula, Henna-Reetta; Jaggi, Matthias; Kolabutin, Nikolai; Krampe, Daniela; Lehning, Michael; Matero, Ilkka; Nicolaus, Marcel; Oggier, Marc; Pirazzini, Roberta; Polashenski, Chris; Raphael, Ian; Regnery, Julia; Shimanchuck, Egor; Smith, Madison M; Tavri, Aikaterini (2022): Snowpit salinity profiles during the MOSAiC expedition. PANGAEA, https://doi.org/10.1594/PANGAEA.946807

Part of a data set collection:
Macfarlane, Amy R; Schneebeli, Martin; Dadic, Ruzica; Wagner, David N; Arndt, Stefanie; Clemens-Sewall, David; Hämmerle, Stefan; Hannula, Henna-Reetta; Jaggi, Matthias; Kolabutin, Nikolai; Krampe, Daniela; Lehning, Michael; Matero, Ilkka; Nicolaus, Marcel; Oggier, Marc; Pirazzini, Roberta; Polashenski, Chris; Raphael, Ian; Regnery, Julia; Shimanchuck, Egor; Smith, Madison M; Tavri, Aikaterini (2021): Snowpit raw data collected during the MOSAiC expedition. PANGAEA, https://doi.org/10.1594/PANGAEA.935934

Abstract:	In the designated snowpits, 100cm3 of snow was collected in the field, melted and measured for salinity in the laboratory on board Polarstern. Salinity of the melted snow samples was measured using the YSI 30 Salinity, Conductivity and Temperature sensor. The transport containers, as well as the YSI tip, were cleaned using milli-Q water. Salinity profiles were measured at the same intervals as density and stable isotope profiles.

FILES
MOSAiC_snowpits_13_salinity.mat
MOSAiC_snowpits_13_salinity_data.xlsx

VARIABLES *.mat
all_data  import from MOSAiC_snowpits_13_salinity_data.xlsx
ASAL      absolute salinity [g/kg]
binedges_log  binedges for plotting
cond      conductivity [microS/cm]
gsw_psu   salinity [psu] calculated from conductivity assuming reference T (=25ºC) and pressure (=1bar) using   gsw_SP_from_C.m
lat       latitude [º]
lon       longitude [º]
Sal       salinity [psu] from the RS salinometer
Sp        salinity [psu], final data set merged ASAL, cond and Sal
T         temperature [ºC]
utc       sampling time [UTC]
z_bot     H rel ice/snow max [m] (sample bop)
z_med     H rel ice/snow max [m] (sample median)
z_top     H rel ice/snow max [m] (sample top)
