clc; clear; close all;

M = [1 3 -1 6; 2 4 0 -1; 0 -2 3 -1; -1 2 -5 1]

format rat
M(2:3, :) = 1/10

M(:, 3) = []

M(1, :) = []

M = [M, [0; 0; 0]; [0, 0, 0, 9/4]]


