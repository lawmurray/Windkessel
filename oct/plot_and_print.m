% Copyright (C) 2013
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_and_print ()
%
% Produce plots and print for manuscript.
% @end deftypefn
%
function plot_and_print ()
    figDir = 'figs';
    ps = [5001:20000];
    ax = [0 2.4 50 200];  % axis extends for time vs pressure plots

    mkdir(figDir);

    % state estimates
    set (figure(1), 'papersize', [11 8]);
    set (figure(1), 'paperposition', [0 0 11 8]);
    orient ('portrait');

    subplot(3, 2, 1);
    bi_plot_paths ('data/input.nc', 'F', [], [], [901:990], 1, 1);
    grid on;
    xlabel('t (s)');
    ylabel('F (ml s^{-1})');
    axis([0 2.4 0 550]);

    subplot(3, 2, 2);
    bi_plot_quantiles ('results/prior.nc', 'Pp');
    hold on;
    bi_plot_quantiles ('results/posterior.nc', 'Pp', [], ps);
    bi_plot_paths ('data/obs.nc', 'Pa', [], [], [301:331]);
    hold off;
    grid on;
    xlabel('t (s)');
    ylabel('P (mm Hg)');
    axis(ax);
    legend({'prior P_p'; ''; 'posterior P_p'; ''; 'observed P_a'});

    subplot(3, 2, 3);
    bi_hist ('results/posterior.nc', 'R', [], ps, [], 12);
    hold on;
    bi_plot_prior (linspace(axis()(1), axis()(2), 500), @gampdf, {2.0, 0.9});
    hold off;
    legend({'posterior'; 'prior'});
    grid on;
    xlabel ('R (mm Hg (ml s^{-1})^{-1})');
    ylabel ('p(R)');
    ax1 = axis();
    axis([ax1(1) ax1(2) ax1(3) 1.2*ax1(4)]);

    subplot(3, 2, 4);
    bi_hist ('results/posterior.nc', 'C', [], ps, [], 12);
    hold on;
    bi_plot_prior (linspace(axis()(1), axis()(2), 500), @gampdf, {2.0, 1.5});
    hold off;
    legend({'posterior'; 'prior'});
    grid on;
    xlabel ('C (mm Hg^{-1})');
    ylabel ('p(C)');
    ax1 = axis();
    axis([ax1(1) ax1(2) ax1(3) 1.2*ax1(4)]);

    subplot(3, 2, 5);
    bi_hist ('results/posterior.nc', 'Z', [], ps, [], 12);
    hold on;
    bi_plot_prior (linspace(axis()(1), axis()(2), 500), @gampdf, {2.0, 0.03});
    hold off;
    legend({'posterior'; 'prior'});
    grid on;
    xlabel ('Z (mm Hg s ml^{-1})');
    ylabel ('p(Z)');
    ax1 = axis();
    axis([ax1(1) ax1(2) ax1(3) 1.2*ax1(4)]);

    subplot(3, 2, 6);
    bi_hist ('results/posterior.nc', 'sigma2', [], ps, [], 12);
    hold on;
    bi_plot_prior (linspace(axis()(1), axis()(2), 500), @invgampdf, {2.0, 1000.0});
    hold off;
    legend({'posterior'; 'prior'});
    grid on;
    xlabel ('\sigma^2 (mm Hg^2)');
    ylabel ('p(\sigma^2)');
    ax1 = axis();
    axis([ax1(1) ax1(2) ax1(3) 1.2*ax1(4)]);

    saveas (figure(1), sprintf('%s/windkessel.svg', figDir));
end
