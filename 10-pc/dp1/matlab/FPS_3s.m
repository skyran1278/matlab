clc; clear; close all;

b = 45;
d = 27;
e = 0.05 * b;
DTD = 0.3;

yx = d / 2;
yy = b / 2;

DDx = DTD / (1 + yx * (12 * e) / (b ^ 2 + d ^ 2));

DDy = DTD / (1 + yy * (12 * e) / (b ^ 2 + d ^ 2));

DD = min(DDx, DDy);

DD = 0.2458;

% ==========================
% T = 2.5;

mu = 0.05;

W = [87.5997 170.9929 341.4667];

% W = [87.5997 174.7421 341.6658];

DampingRatio = 0.3;

R = DD / ((2 * mu) / (pi * DampingRatio) - mu);

KeD = W / R + mu * W / DD;

Kh = W / R
K1 = 51 * Kh;
g = 9.81;

if DD > mu * R
    DD;
    mu * R;
    fprintf('OK\n');
else
    DD
    mu * R
    fprintf('NG\n');
end

fprintf('============================');
KeD
K1
mu
R
T = 2 * pi * sqrt((W / g) ./ KeD)
(37.8137 * 4 + 73.8117 * 12 + 147.3993 * 8) / 24 * 1000 * 9.81
T_check = 2 * pi * sqrt(R / g)

W = 87.5997;
K1 = 1019.7;
x = -0.2458 : 0.0001 : 0.2458;
y1 = W / R * x + mu * W;
y2 = W / R * x - mu * W;
y3 = (W / R + mu * W / DD) * x;
k1x = 0.237 : 0.0001 : 0.2458;
y4 = K1 * (k1x - 0.2458) + (W / R * 0.2458 + mu * W);

figure;
plot(x, y1, x, y2, x, y3, k1x, y4);
title('');
xlabel('');
ylabel('');
% axis([-0.35 0.35 -0.6 0.6]);
