clc; clear; close all;

% SaD = 0.2324;
% TeD = 2.5;
% DampingRatio = 0.25;
SaD = 0.195;
TeD = 3;
DampingRatio = 0.2;

W = 35.53421364;
postYieldingRatio = 0.1;
LRBs = 9;

dleta = 0.000001;
g = 9.81;

KeD = W / ((TeD / (2 * pi)) ^ 2) / g;

if DampingRatio <= 0.02
    BS = 0.8;
    B1 = 0.8;
elseif 0.02 < DampingRatio && DampingRatio <= 0.05
    BS = (DampingRatio - 0.02) / 0.03 * (1 - 0.8) + 0.8;
    B1 = (DampingRatio - 0.02) / 0.03 * (1 - 0.8) + 0.8;
elseif 0.05 < DampingRatio && DampingRatio <= 0.1
    BS = (DampingRatio - 0.05) / 0.05 * (1.33 - 1) + 1;
    B1 = (DampingRatio - 0.05) / 0.05 * (1.25 - 1) + 1;
elseif 0.1 < DampingRatio && DampingRatio <= 0.2
    BS = (DampingRatio - 0.1) / 0.1 * (1.6 - 1.33) + 1.33;
    B1 = (DampingRatio - 0.1) / 0.1 * (1.5 - 1.25) + 1.25;
elseif 0.2 < DampingRatio && DampingRatio <= 0.3
    BS = (DampingRatio - 0.2) / 0.1 * (1.79 - 1.6) + 1.6;
    B1 = (DampingRatio - 0.2) / 0.1 * (1.63 - 1.5) + 1.5;
elseif 0.3 < DampingRatio && DampingRatio <= 0.4
    BS = (DampingRatio - 0.3) / 0.1 * (1.87 - 1.79) + 1.79;
    B1 = (DampingRatio - 0.3) / 0.1 * (1.7 - 1.63) + 1.63;
elseif 0.4 < DampingRatio && DampingRatio <= 0.5
    BS = (DampingRatio - 0.4) / 0.1 * (1.93 - 1.87) + 1.87;
    B1 = (DampingRatio - 0.4) / 0.1 * (1.75 - 1.7) + 1.7;
elseif 0.5 < DampingRatio
    BS = 1.93;
    B1 = 1.75;
end

B = B1;

DD = g / (4 * pi ^ 2) * SaD * TeD ^ 2 / B;

% syms Qd; % be careful performance issue.

% Kd = KeD - Qd / DD;

% Ku = Kd / postYieldingRatio;

% Dy = Qd / (Ku - Kd);

% ATD = 4 * Qd * (DD - Dy);

% solQd = double(solve(DampingRatio == ATD / (2 * pi * KeD * DD ^ 2), Qd))

Qd = dleta;
nextDampingRatio = 0;

while abs(nextDampingRatio - DampingRatio) > dleta

    Kd = KeD - Qd / DD;

    Ku = Kd / postYieldingRatio;

    Dy = Qd / (Ku - Kd);

    ATD = 4 * Qd * (DD - Dy);

    nextDampingRatio = ATD / (2 * pi * KeD * DD ^ 2);

    Qd = Qd + dleta;

end

B
DD
KeD

% Fy1 = Ku * Dy / LRBs

singleKu = Ku / LRBs
singleKd = Kd / LRBs
singleQd = Qd / LRBs

fprintf('======================');
singleKeD = KeD / LRBs
DampingRatio
singleKu = Ku / LRBs
Fy = (Qd + Kd * Dy) / LRBs
postYieldingRatio

x = -0.3 : 0.01 : 0.3;
y1 = singleKu * x;
y2 = singleKd * x + singleQd;
y3 = singleKeD * x;
y4 = singleKd * x - singleQd;

figure;
plot(x, y1, x, y2, x, y3, x, y4);
title('');
xlabel('');
ylabel('');
axis([-0.35 0.35 -0.6 0.6]);
