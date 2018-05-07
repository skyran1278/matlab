clc; clear; close all;

theta_elastic = 0 : 1e-4 : 3.5e-3;

theta_inelastic = 3.5e-3 : 1e-4 : 0.03;

epsilon_elastic = 0.49 * theta_elastic;

epsilon_inelastic = 0.65 * theta_inelastic - 5.41e-4;

epsilon_x = @(x) (0.49 * x) .* (x <= 3.5e-3) + (0.65 * x - 5.41e-4) .* (x > 3.5e-3);

% epsilon = zeros(1, length(theta_));
theta_ = 0 : 1e-4 : 0.03;

epsilon = epsilon_x(theta_);

% epsilon = length(theta_);

% for index = 1 : length(theta_)
%     epsilon(index) = epsilon_x(index);

% end



plot(theta_elastic, epsilon_elastic, theta_inelastic, epsilon_inelastic);

figure;
plot(theta_, epsilon_x(theta_));
