clc; clear; close all;

% b = 45;
% d = 27;
% e = 0.05 * b;
% DTD = 0.3;

% yx = d / 2;
% yy = b / 2;

% DDx = DTD / (1 + yx * (12 * e) / (b ^ 2 + d ^ 2));

% DDy = DTD / (1 + yy * (12 * e) / (b ^ 2 + d ^ 2));

% DD = min(DDx, DDy);

DD = 0.2458;

% ==========================
% T = 2.5;

mu = 0.0455;

W = [87.5997 170.9929 341.4667];

% W = [87.5997 174.7421 341.6658];

DampingRatio = 0.3;

R = DD / ((2 * mu) / (pi * DampingRatio) - mu);

KeD = W / R + mu * W / DD;

Kh = W / R;
K1 = 51 * Kh;
g = 9.81;

if DD > mu * R
    DD
    mu * R
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
(34.4105 * 4 + 67.1686 * 12 + 134.1333 * 8) / 24 * 1000 * 9.81
Kh
fprintf('%.4f   ',K1)
K1