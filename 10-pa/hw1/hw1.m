clc; clear; close all;


alpha_ = 0 : 0.3 : 4;
beta_ = 0.5;
alphaLength = length(alpha_);

xi = (1 + alpha_ .^ 2 * beta_) ./ (3 + 2 * alpha_);

Mc = abs(-3 / 2 * xi);
Mb = abs(alpha_ * beta_ - 3 / 4 * xi);
Md = abs(1  - 3 / 2 * xi);

McHinge = 1 / 2 * ones(1, alphaLength);
MdHinge = 1 / 2 * ones(1, alphaLength);
MbHinge = abs(alpha_ * beta_ - 1 / 4);

figure;
hold on;
plot(alpha_, Mc, '-o');
plot(alpha_, Mb, '-+');
plot(alpha_, Md, '-*');
plot(alpha_, McHinge, ':o');
plot(alpha_, MdHinge, ':+');
plot(alpha_, MbHinge, ':*');
legend('MB','MC','MD','MB-hinge','MC-hinge','MD-hinge','Location','northwest');title('');
xlabel('$$\alpha$$','Interpreter','latex');
ylabel('$$|\frac{M}{\frac{PL}{4}}|$$','Interpreter','latex');

alpha_ = 0 : 0.03 : 4;
beta_ = 0.5;
alphaLength = length(alpha_);

xi = (1 + alpha_ .^ 2 * beta_) ./ (3 + 2 * alpha_);

Mc = abs(-3 / 2 * xi);
Mb = abs(alpha_ * beta_ - 3 / 4 * xi);
Md = abs(1  - 3 / 2 * xi);

McHinge = 1 / 2 * ones(1, alphaLength);
MdHinge = 1 / 2 * ones(1, alphaLength);
MbHinge = abs(alpha_ * beta_ - 1 / 4);

figure;
hold on;
plot(alpha_, max([Mc; Mb; Md]));
plot(alpha_, max([McHinge; MbHinge; MdHinge]));
title('');
legend('structure #1','structure #2','Location','northwest');
xlabel('$$\alpha$$','Interpreter','latex');
ylabel('$$|\frac{M}{\frac{PL}{4}}|$$','Interpreter','latex');
