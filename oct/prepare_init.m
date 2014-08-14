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
    file = 'data/init.nc';
    try
        nccreate(file, 'R');
        nccreate(file, 'C');
        nccreate(file, 'Z');
        nccreate(file, 'sigma2');
    catch
        % assume variables already exist...
    end
    ncwrite(file, 'R', 0.95);
    ncwrite(file, 'C', 1.5);
    ncwrite(file, 'Z', 0.033);
    ncwrite(file, 'sigma2', 50000.0);
end
