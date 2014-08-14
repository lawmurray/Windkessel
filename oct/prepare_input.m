% Copyright (C) 2011-2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev: 2272 $
% $Date: 2011-12-12 19:53:13 +1100 (Mon, 12 Dec 2011) $

% -*- texinfo -*-
% @deftypefn {Function File} {} prepare_input ()
%
% Prepare input file of aortic blood flow.
%
% @end deftypefn
%
function prepare_input
    delta = 0.01;  % time step (s)
    n = 33;        % number of cycles
    Tc = 0.8;      % period (s)
    Ts = 0.3;      % systolic part of period (s)
    Fmax = 500.0;  % maximum flow (mL/s)

    r = repmat([0:n]*Tc, Ts/delta + 1, 1)(:);
    s = repmat(linspace(0, Ts, Ts/delta + 1), 1, n + 1)(:);
    t = r + s - 24;
    
    F = Fmax*sin(pi*s/Ts).^2;
    
    file = 'data/input.nc';
    try
      nccreate(file, 'time', 'Dimensions', {'nr'; length(t)});
      nccreate(file, 'F', 'Dimensions', {'nr'; length(t)});
    catch
      % assume variables already exist
    end
    ncwrite(file, 'time', t);
    ncwrite(file, 'F', F);
end
