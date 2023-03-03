% do_gsw_SA_from_SP(C,T,p);
%
% input - C (mS/cm)
% output - out (psu)

SP = all_snow(:,9);
lat = repmat(-65,1,length(SP))'; % 65ºS 
long = repmat(-25,1,length(SP))'; % 25ºW
p = repmat(10,1,length(SP))';  % atmospheric pressure in dbar (1 dbar = 1e-1 bar)
[SA, in_ocean] = gsw_SA_from_SP(SP,p,long,lat)