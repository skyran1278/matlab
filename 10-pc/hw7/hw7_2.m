clc; clear; close all;

SaD = 0.2321;
W = 35.53421364;
TeD = 2.5;
DampingRatio = 0.25;

postYieldingRatio = 0.1;

dleta = 0.000001;
g = 9.81;

KeD = W / ((TeD / (2 * pi)) ^ 2) / g;

% DampingRatio = 25%
B = (DampingRatio - 0.2) / 0.1 * (1.63 - 1.5) + 1.5;

DD = g / (4 * pi ^ 2) * SaD * TeD ^ 2 / B;

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

% syms symKu; % be careful performance issue.

% Qd = dleta;
% nextKeD = 0;

% while abs(nextKeD - KeD) > dleta

%     Kd = postYieldingRatio * symKu;

%     Dy = Qd / (symKu - Kd);

%     ATD = 4 * Qd * (DD - Dy);

%     Ku = solve(DampingRatio == ATD / (2 * pi * KeD * DD ^ 2), symKu);

%     Kd = postYieldingRatio * Ku;

%     nextKeD = double(Kd + Qd / DD);

%     Qd = Qd + dleta;

% end

Fy1 = Ku * Dy
Fy2 = Qd + Kd * Dy

Ku
Kd
Qd

KeD
B
DD
