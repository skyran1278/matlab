clc; clear; close all;

M = 2.5 * eye(6);

KPart = [-3200 -3200 -2400 -2000 -1600];
K = diag([6400, 6400, 5600, 4400, 3600, 1600]) + diag(KPart, 1) + diag(KPart, -1);

XI = 0.02 * eye(6);

[PHI, LAMBDA] = eig(M \ K);
% [PHI, LAMBDA] = eig(K, M);

G = - M * ones(6, 1);
% -------------------------------------------------
% -------------------------------------------------
% (b)
Wn = sqrt(LAMBDA);

C = PHI.' \ (2 * XI * Wn) * PHI.' * M;

NormalizingPHI = (1 ./ max(PHI)) .* PHI;
NormalizingPHIPlus0 = [zeros(1, 6) ;NormalizingPHI];

figure;

for index = 1 : 6
  subplot(1, 6, index);
  plot(NormalizingPHIPlus0(:, index), 0 : 6);
  set(get(gca, 'Title'), 'String', [num2str(index) ' - mode']);
  hold on;
end

Mr = PHI.' * M * PHI
Cr = PHI.' * C * PHI
Kr = PHI.' * K * PHI
Gr = PHI.' * G

Gr ./ sum(Mr).'