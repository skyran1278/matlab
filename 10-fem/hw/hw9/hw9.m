clc; clear; close all;

x1 = [2 0 0 4 2];
y1 = [4 4 0 -4 4];
y2 = 0 : 0.01 : 4;
x2 = 0.5 .* sqrt(y2) .* (4 - sqrt(y2));

figure;
plot(x1, y1, 'b-o', x2, y2, 'k--');
title('physical coordination');
xlabel('x');
ylabel('y');
legend('physical shape', 'cooresponding line', 'Location', 'northeast');
axis([-3 7 -4 4]);
