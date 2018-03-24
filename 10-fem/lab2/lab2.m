clc; clear; close all;

x = 20 : 20 : 180;
y = [75 43 26 16 10 5 3.5 1.8 1.6];
err = [4 3 3 3 2 2 1 1 1];

figure;
errorbar(x, y, err,'k.', 'MarkerSize', 20);
title('linear plot of a reactant versus time', 'FontSize', 12);
xlabel('time t/s');
ylabel('concentation c/mmolL^-^1');
axis([0 200 0 80]);

figure;
ax = errorbar(x, y, err,'.', 'MarkerSize', 20);
title('logarithmic plot of a reactant versus time', 'FontSize', 12);
xlabel('time t/s');
ylabel('concentation c/mmolL^-^1');
axis([0 200 00.1 100]);
set(gca, 'YScale', 'log');

