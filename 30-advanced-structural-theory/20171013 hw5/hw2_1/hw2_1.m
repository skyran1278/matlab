% R06521217 �D�ɵM ����HW2_1

% �����e�@���@�~
clc; clear; close all;

A = magic(3)

A = A + eye(3)

A = [ A.' A ]

A(:, [ 1 2 4 6 ]) = []

A = fliplr(A)

A(3, :) = 1