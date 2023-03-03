function [PSU] = conduc2sali_gsw_from_SP()
% gsw_SP_from_C                        Practical Salinity from conductivity 
%==========================================================================
%
% USAGE: 
%  SP = gsw_SP_from_C(C,t,p)
%
% DESCRIPTION:
%  Calculates Practical Salinity, SP, from conductivity, C, primarily using
%  the PSS-78 algorithm.  Note that the PSS-78 algorithm for Practical 
%  Salinity is only valid in the range 2 < SP < 42.  If the PSS-78 
%  algorithm produces a Practical Salinity that is less than 2 then the 
%  Practical Salinity is recalculated with a modified form of the Hill et 
%  al. (1986) formula.  The modification of the Hill et al. (1986)
%  expression is to ensure that it is exactly consistent with PSS-78 
%  at SP = 2.  Note that the input values of conductivity need to be in 
%  units of mS/cm (not S/m). 
%
% INPUT:
%  C  =  conductivity                                             [ mS/cm ]
%  t  =  in-situ temperature (ITS-90)                             [ deg C ]
%  p  =  sea pressure                                              [ dbar ]
%        ( i.e. absolute pressure - 10.1325 dbar )
%
%  t & p may have dimensions 1x1 or Mx1 or 1xN or MxN, where C is MxN.
%
% OUTPUT:
%  SP  =  Practical Salinity on the PSS-78 scale               [ unitless ]
%
% AUTHOR:  
%  Paul Barker, Trevor McDougall and Rich Pawlowicz    [ help@teos-10.org ]
%
% VERSION NUMBER: 3.05 (27th January 2015)
%
% REFERENCES:
%  Culkin and Smith, 1980:  Determination of the Concentration of Potassium  
%   Chloride Solution Having the Same Electrical Conductivity, at 15C and 
%   Infinite Frequency, as Standard Seawater of Salinity 35.0000 
%   (Chlorinity 19.37394), IEEE J. Oceanic Eng, 5, 22-23.
%
%  Hill, K.D., T.M. Dauphinee & D.J. Woods, 1986: The extension of the 
%   Practical Salinity Scale 1978 to low salinities. IEEE J. Oceanic Eng.,
%   11, 109 - 112.
%
%  IOC, SCOR and IAPSO, 2010: The international thermodynamic equation of 
%   seawater - 2010: Calculation and use of thermodynamic properties.  
%   Intergovernmental Oceanographic Commission, Manuals and Guides No. 56,
%   UNESCO (English), 196 pp.  Available from http://www.TEOS-10.org
%    See appendix E of this TEOS-10 Manual. 
%
%  Unesco, 1983: Algorithms for computation of fundamental properties of 
%   seawater. Unesco Technical Papers in Marine Science, 44, 53 pp.
%
%  The software is available from http://www.TEOS-10.org
%
%==========================================================================
% based on final data set in SNOW_blowsea.xls
fname = '~/Documents/research/Antarctica/BLOWSEA/DATA/SNOW/data/SNOW_stats.mat';
load(fname)

C = mS_psu_all(:,1);    % conductivity (mS/cm): T-corrected salinometer output
T = repmat(25,1,length(C))';  % temperature (ºC): reference temperature 25ºC
p = repmat(10,1,length(C))';  % atmospheric pressure in dbar (1 dbar = 1e-1 bar)

PSU = gsw_SP_from_C(C,T,p);