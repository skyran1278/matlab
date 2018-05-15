clc; clear; close all;

syms T1 T2 T3;

AB = [1, 3, 5];
AC = [-3, 0, 5];
AD = [1, -4, 5];

eqns = [T1 * AB(3) / norm(AB) + T2 * AC(3) / norm(AC) + T3 * AD(3) / norm(AD) == 6, T1 * AB(2) / norm(AB) + T2 * AC(2) / norm(AC) + T3 * AD(2) / norm(AD) == 0, T1 * AB(1) / norm(AB) + T2 * AC(1) / norm(AC) + T3 * AD(1) / norm(AD) == 0];

vars = [T1, T2, T3];

[T1, T2, T3] = solve(eqns, vars);

eval([T1, T2, T3])
