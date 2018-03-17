% R06521217 乃宥然 高結HW2_1

% 消除前一次作業
clc; clear; close all;

A = magic(3)

A = A + eye(3)

A = [ A.' A ]

A(:, [ 1 2 4 6 ]) = []

A = fliplr(A)

A(3, :) = 1