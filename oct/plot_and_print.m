% Copyright (C) 2013-2014
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
    ps = [5001:50000]; % sample range for PMMH
    mkdir(figDir);

    % state estimates
    set (figure(1), 'papersize', [8 11]);
    orient ('tall');

    subplot(3, 2, 1);
    bi_plot_paths ('data/input.nc', 'F', [], [], [], 1, 1);
    grid on;
    xlabel('t (s)');
    ylabel('F (ml s^{-1})');
    ax = axis();
    axis([0 2.4 ax(3) 1.2*ax(4)]);

    subplot(3, 2, 2);
    bi_plot_quantiles ('results/prior.nc', 'Pp');
    hold on;
    bi_plot_quantiles ('results/posterior.nc', 'Pp', [], ps);
    bi_plot_paths ('data/obs.nc', 'Pa', [], [], [301:331]);
    hold off;
    grid on;
    xlabel('t (s)');
    ylabel('P (mm Hg)');
    ax = axis();
    axis([0 2.4 ax(3) ax(4)]);
    legend({'prior P_p'; ''; 'posterior P_p'; ''; 'observed P_a'});
    legend('boxoff');

    subplot(3, 2, 3);
    bi_hist ('results/posterior.nc', 'R', [], ps, [], 16);
    hold on;
    bi_plot_prior (linspace(axis()(1), axis()(2), 500), @gampdf, {2.0, 0.9});
    hold off;
    legend({'posterior'; 'prior'});
    legend('boxoff');
    grid on;
    xlabel ('R (mm Hg (ml s^{-1})^{-1})');
    ylabel ('p(R)');
    ax = axis();
    axis([ax(1) ax(2) ax(3) 1.2*ax(4)]);

    subplot(3, 2, 4);
    bi_hist ('results/posterior.nc', 'C', [], ps, [], 16);
    hold on;
    bi_plot_prior (linspace(axis()(1), axis()(2), 500), @gampdf, {2.0, 1.5});
    hold off;
    legend({'posterior'; 'prior'});
    legend('boxoff');
    grid on;
    xlabel ('C (mm Hg^{-1})');
    ylabel ('p(C)');
    ax = axis();
    axis([ax(1) ax(2) ax(3) 1.2*ax(4)]);

    subplot(3, 2, 5);
    bi_hist ('results/posterior.nc', 'Z', [], ps, [], 16);
    hold on;
    bi_plot_prior (linspace(axis()(1), axis()(2), 500), @gampdf, {2.0, 0.03});
    hold off;
    legend({'posterior'; 'prior'});
    legend('boxoff');
    grid on;
    xlabel ('Z (mm Hg s ml^{-1})');
    ylabel ('p(Z)');
    ax = axis();
    axis([ax(1) ax(2) ax(3) 1.2*ax(4)]);

    subplot(3, 2, 6);
    bi_hist ('results/posterior.nc', 'sigma2', [], ps, [], 16);
    hold on;
    bi_plot_prior (linspace(axis()(1), axis()(2), 500), @invgampdf, {2.0, 500000.0});
    hold off;
    legend({'posterior'; 'prior'});
    legend('boxoff');
    grid on;
    xlabel ('\sigma^2 (mm^2 Hg^2)');
    ylabel ('p(\sigma^2)');
    ax = axis();
    axis([ax(1) ax(2) ax(3) 1.2*ax(4)]);
    %set (gca, 'xticklabel', get(gca, 'xtick')/1e6);
    %set (gca, 'yticklabel', get(gca, 'ytick')*1e6);

    saveas (figure(1), sprintf('%s/windkessel.svg', figDir));
end
