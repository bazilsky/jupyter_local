% do_gsw_SP_from_C(C,T,p);
%
% input - C (mS/cm)
% output - out (psu)


T = repmat(25,1,length(C))';  % temperature (�C): reference temperature 25�C
p = repmat(10,1,length(C))';  % atmospheric pressure in dbar (1 dbar = 1e-1 bar)
PSU = gsw_SP_from_C(C,T,p);