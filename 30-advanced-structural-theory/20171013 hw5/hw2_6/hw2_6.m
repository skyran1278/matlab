% R06521217 乃宥然 高結HW2_6

% 消除前一次作業
clc; clear; close all;

syms x1 x2 x3;

tic;
[solveX1, solveX2, solveX3 ] = solve(7 * x1 + 2 * x2 + 6 * x3 == 660, 3 * x1 - 5 * x2 + 5 * x3 == 160, 4 * x1 - 2 * x2 + 7 * x3 == 470, x1, x2, x3);
solveTime = toc;


tic;
invX = inv([ 7 2 6; 3 -5 5; 4 -2 7 ]) * [ 660; 160; 470 ];
invTime = toc;


tic;
leftDivisionX = [ 7 2 6; 3 -5 5; 4 -2 7 ] \ [ 660; 160; 470 ];
leftDivisionTime = toc;

fprintf('using ''solve'' :\nx1=%.0f, x2=%.0f, x3=%.0f, time=%f\n', solveX1, solveX2, solveX3, solveTime);
fprintf('using ''inv'' :\nx1=%.0f, x2=%.0f, x3=%.0f, time=%f\n', invX(1), invX(2), invX(3), invTime);
fprintf('using ''left division'' :\nx1=%.0f, x2=%.0f, x3=%.0f, time=%f\n', leftDivisionX(1), leftDivisionX(2), leftDivisionX(3), leftDivisionTime);
