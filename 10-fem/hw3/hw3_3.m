clc; clear; close all;

syms x;

xe = [0 15 30 45 60 75 90];

N = sym(ones(7, 1));

for i = 1 : length(N)
    xj = (xe(xe ~= xe(i)));
    N(i, 1) = simplify(prod((x - xj) ./ (xe(i) - xj)));
end

thickness = 10; % mm
Ae = thickness * [8 10 9 12 12 10 5];

A(x) = Ae * N

t = 0 : 0.01 : 90;

figure;
plot(t, A(t));
title('Interpolated Cross-Section Area');
xlabel('x (mm)');
ylabel('cross-sectional area (mm^2)');
yticks([50 100 150]);
axis([0 90 50 150]);
grid on;

y = A(t) / thickness / 2;
ye = Ae / thickness / 2;
figure;
plot(t, y, t, - y, xe, ye, 'o', xe, - ye, 'o');
title('Interpolated Shape');
xlabel('x (mm)');
ylabel('y (mm)');
axis([0 90 -10 10]);
yticks([-10 0 10]);
grid on;
