clc; clear; close all;

K = [ 600 -600 0; -600 1800 -1200; 0 -1200 3000 ];
M = [ 1 0 0; 0 2 0; 0 0 2 ];

phi = [ 1 1 0.31386; 0.68614 -0.5 -0.68614; 0.31386 -0.5 1 ];

% (a)
modalM = transpose(phi) * M * phi;
modalK = transpose(phi) * K * phi;

omegaSquare = [ 188.32 900 1911.7 ];

omega = sqrt(omegaSquare);

Sv = [ 11 6 4 ];
Sa = [ 0.5 0.5 0.5 ];

mu = transpose(phi) * M * [1; 1; 1];
condenseModalM = sum(modalM);
maxDisplacement = SquareSumSqrt(phi(1, :) .* transpose(mu) ./ condenseModalM ./ omega .* Sv)

maxBaseShear = SquareSumSqrt(transpose(mu .^ 2) ./ condenseModalM .* Sa)

function output = SquareSumSqrt(value)
  output = sqrt(sum(value .^ 2));
end
