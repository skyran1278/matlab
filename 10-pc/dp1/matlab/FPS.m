clc; clear; close all;

b = 45;
d = 27;
e = 0.05 * b;
DTD = 0.3;

yx = d / 2;
yy = b / 2;

DDx = DTD / (1 + yx * (12 * e) / (b ^ 2 + d ^ 2));

DDy = DTD / (1 + yy * (12 * e) / (b ^ 2 + d ^ 2));

DD = min(DDx, DDy)

T = 2.5;
R = 0.25 * T ^ 2

mu = 0.08;

W = [87.5997 170.9929 341.4667];

DampingRatio = 0.3;

R = DD / ((2 * mu) / (pi * DampingRatio) - mu);

KeD = W / R + mu * W / D
