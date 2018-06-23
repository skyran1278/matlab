clc; clear; close all;

syms xi; % be careful performance issue.

B = [-1/2, 1/2, sqrt(6)/2*xi];

N(xi) = [(1 - xi) / 2, (1 + xi) / 2, 3 / sqrt(6) / 2 * (xi ^ 2 - 1)];

k = double(int(B.' * B, -1, 1))

f = double(int(N.' * 2 * (2 + xi), -1, 1) + 0.1 * (N(-1)).')

% U = k \ f
displacements = solution(3, 2, k, f, [0 0.01 0].')
