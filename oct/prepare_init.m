% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 2272 $
% $Date: 2011-12-12 19:53:13 +1100 (Mon, 12 Dec 2011) $

% -*- texinfo -*-
% @deftypefn {Function File} {} prepare_init ()
%
% Prepare init file.
%
% @end deftypefn
%
function prepare_init
    nc = netcdf('data/init.nc', 'c');
    nc{'R'} = ncdouble ();
    nc{'C'} = ncdouble ();
    nc{'Z'} = ncdouble ();
    nc{'sigma2'} = ncdouble ();
    
    nc{'R'}(:) = 0.95;
    nc{'C'}(:) = 1.5;
    nc{'Z'}(:) = 0.033;
    nc{'sigma2'}(:) = 100.0;
    
    ncclose (nc);
end
