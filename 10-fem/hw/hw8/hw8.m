clc; clear; close all;

syms x;

double(int(8 / sqrt(65) * (10 * x - 1) ^ 2, x, 0, -0.1))
double(int(1 / sqrt(65) * ((10 * x - 1) ^ 2), x, 0, -0.1))
double(int(8 / sqrt(65) * (-10 * x) ^ 2, x, 0, -0.1))
double(int(1 / sqrt(65) * ((-10 * x) ^ 2), x, 0, -0.1))
