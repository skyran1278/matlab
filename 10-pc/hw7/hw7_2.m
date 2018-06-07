clc; clear; close all;

g = 9.81;

SaD = 0.2321;
W = 35.53421364;

TeD = 2.5;
DampingRatio = 0.25;

postYieldingRatio = 0.1;

dleta = 0.01;


KeD = W / ((TeD / (2 * pi)) ^ 2) / g;

% DampingRatio = 25%
B = (DampingRatio - 0.2) / 0.1 * (1.63 - 1.5) + 1.5;

DD = g / (4 * pi ^ 2) * SaD * TeD ^ 2 / B;


syms symKu; % be careful performance issue.

Qd = dleta;
nextKeD = 0;

while abs(nextKeD - KeD) > dleta

    Kd = postYieldingRatio * symKu;

    Dy = Qd / (symKu - Kd);

    ATD = 4 * Qd * (DD - Dy);

    Ku = solve(DampingRatio == ATD / (2 * pi * KeD * DD ^ 2), symKu);

    Kd = postYieldingRatio * Ku;

    nextKeD = double(Kd + Qd / DD)

    Qd = Qd + dleta;

end

Dy = Qd / (Ku - Kd);
Fy = Ku * Dy;
