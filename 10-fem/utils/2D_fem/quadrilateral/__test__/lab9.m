clc; clear; close all;

lab9_9R
lab9_8R
lab9_9IR
lab9_8IR

figure(1);
x = 0 : 0.01 : 5;
M = 600;
b = 1;
h = 0.5;
I = 1 / 12 * b * h ^ 3;

exactDisplacements = - M * x .^ 2 / (2 * E * I);

exactDisplacement = plot(x, exactDisplacements, 'k-');
hold on;
legend([r9Displacement, r8Displacement, ir9Displacement, ir8Displacement, exactDisplacement], 'R-Q9', 'R-Q8', 'IR-Q9', 'IR-Q8', 'exact', 'Location', 'northeast');
grid on;

figure(2);
x = 0 : 0.01 : 5;
M = 600;
b = 1;
h = 0.5;
I = 1 / 12 * b * h ^ 3;

displacements = - M * x .^ 2 / (2 * E * I);

y = gpLocation(4, 2) - 0.25;
stress = M * y / I * ones(1, length(x));

exactStress = plot(x, stress, 'k-');
hold on;
grid on;
legend([r9Stress, r8Stress, ir9Stress, ir8Stress, exactStress], 'R-Q9', 'R-Q8', 'IR-Q9', 'IR-Q8', 'exact', 'Location', 'northeast');
