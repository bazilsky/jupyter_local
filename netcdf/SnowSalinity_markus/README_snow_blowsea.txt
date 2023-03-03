*******************************************************************************************************************
README								BLOWSEA SNOW SAMPLES

file updates:
MF Cambridge, Aug 2018

*******************************************************************************************************************
FILES
SNOW_blowsea.xlsx
SNOW_stats_blowsea.mat (from sheet SNOW-stats in SNOW_blowsea.xlsx)
SNOW_pits_blowsea.mat  (from sheet SNOW-results in SNOW_blowsea.xlsx)

VARIABLES



i) SAMPLING
stainless steal snow sampler use: collected x10 2cm-samples, filled flasks from bottom to top sample

ii) SALINITY
- instrument:
conductivity meter (Hach SensIon5)
range (resolution) 0-199.9 (0.1) �S; 200-19,999 (10) �S; 2-19.99 (0.01) mS; 20-199.9 (0.1) mS
automatic non-linear temperature compensation based on NaCl solution & reference temperature T=25�C
resolution of 0.1 �S or 0.0001 mS corresponds to <0.0001 psu
accuracy: �0.5% of range i.e. �1 �S in the 0-199.9 �S range; 1 �S = 0.001 psu


- calibration:
Cell constant 0.437 1/cm; calibration on 23.06.2013 with a standard salt solution (REAGECON Prod. No. CSKC12880 Lot No. CS1288012K1) of 12.880 mS/cm at 25.1�C, certified & traceable to N.I.S.T. The calibration temperature was ~23.2 �C.

- Notes:
previous user may have underestimated salinities (e.g. Tab.1 in Obbard et al, 2009: sea water salinity of 5.7 psu seems too low). Conductivity meter was calibrated on 23.06.2013. Antarctic Sea Water with the old calibration is 16.9 psu, with the new calibration 32.7 psu.
the instrument can be calibrated with STDs in different concentration ranges; note cell constant, and set according to the samples to be run (see manual)

- data:
instrument reading of conductivity has more significant digits (0.0001-0.01 mS) than that of salinity (0.1 psu). In order to obtain the maximum number of significant digits for salinity (psu) two methods are applied to convert instrument readings of conductivity into salinity (psu)
a) use of the oceanographer toolbox TEOS-10 to recalculate psu (gsw_SP_from_C.m in \gsw_matlab_v3_06_7\)
(http://www.TEOS-10.org)
b) interpolation of instrument salinity (psu) vs instrument conductivity (mS/cm) with a 5th order polynomial fit
p5 -6.76194059995710e-08	p4 8.38966510512769e-06		p3 -0.000397684044925566		p2  0.0105689070851375		p1 0.488598618851120 		p0 0

NOTE: only a) is used, polynom is less accurate

iii) IC ANALYSIS
(a) METHODS
Ion chromatography, columns & eluent
sample dilution: snow (x10 to x100), BSn (x100), sea ice & FF (x10000)

cations: Na (K, Mg, Ca)
reference material ERM-CA616 Groundwater (Batch No. 0024 opened August 2011)
certified concentration		/		Diluted by 100
Na 28+-0.80 ppm			/		279 (271-287) ppb
STDs:
Na 20, 50, 100, 200, 500,1000, 2000 ppb

anions: Cl, NO3, SO4 (F, MSA)
reference material ERM-CA408 Simulated Rainwater (Batch No. 0046 opened August 2011)
certified concentration		/		Diluted by 10
Cl 1.96+-0.07 ppm		/		196 (189-203) ppb
NO3 2.01+-0.09 ppm		/		201 (192-210) ppb
SO4 1.46+-0.04 ppm		/		146 (142-150) ppb

STDs:
Cl 12, 30, 60, 120, 180, 300, 480, 600, 1200, 1800, 3000 ppb
SO4 12, 30, 60, 120, 180, 300, 480, 600, 1200, 1800, 3000 ppb
Br 2, 5, 10, 20, 30, 50, 80, 100, 200, 300, 500 ppb
NO3 2, 5, 10, 20, 30, 50, 80, 100, 200, 300, 500 ppb

blanks:
Cations (na), lab MQ blank always n.a.
Anions (br, so4, cl, no3): lab MQ 1.30   0.08	0.79		0.20 ppbw


(b) RESULTS
IC analysis: na, no3, cl, br, so4 & Salinity
- Batch1 (Feb-2014): Data look not right; dilution needed for many of the samples
- Batch2 (March to May  2014): June 2014 pre-processing for PAGES workshop; Jan-2015 final (re-)processing (May 2014.xls)
- Batch3 (Dec 2016): high salinity samples & reruns

- Cations
Samples analysed more than once are screened: smaller dilution factor is preferred (dilution introduces more uncertainty), also May over April measurements; runs of same dilutions repeated on the same day are averaged; some of the repeats vary by factor 5-10 (?), however no obvious carry-over from previous sample
- Anions
better reproducibility compared to cations, e.g. P408 x10 in 5 runs (BT140501, BT140506, BT140325, BT140319, BT140408); x10000 dilution often too dilute, leading to larger error; nitrate high



******************************************************************************************************************************************************
SAMPLE STATISTICS
24 snow pits at 9 different locations / ice floes

- snow depth mean (median) +-1std
28 (23) +-17cm; range 10-86 cm (N=24)
~50% variability on any ice floe possible
IST5 range 9.5-23cm(N=8)
IST7 range 28-58cm (N=5)

- salinity (median) +-1std
1.67 (0.10) +-5.86mS/cm (N=213, all)
0.57 (0.13) +-1.57mS/cm (N=101, top 10cm only)

- analysis status
49 profiles w/ a total of 649 snow samples taken
samples for salinity: 254
samples for IC analysis: 215 (194 analysed)
samples for ICPMS: 180 (not analysed)

42 samples not analysed (24/11/2016):
cation AND anion: 21
anion OR cation: 23
un-identified SPL: 4
ICPMS: 180
