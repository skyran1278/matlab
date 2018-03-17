clc; clear; close all;

T = 0.2 : 0.2 : 2;

Sv = [ 0.7 1.26 1.27 1.15 1.13 1.11 1.09 1.07 1.06 1.05 ];

Sa = Sv ./ T * 2 * pi();

splineT = 0.2 : 0.01 : 2;

splineSa = spline(T, Sa, splineT);

plot(T, Sa, '*', splineT, splineSa);

legend('Sa', 'Interpolated Sa')
xlabel('Period (sec)');
ylabel('Sa');