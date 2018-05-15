clc; clear; close all;

input_times = input('Enter the number of trial: ');

rand_array = rand(2, input_times);
monte_carlo = sqrt(rand_array(1, :).^2 + rand_array(2, :).^2) <= 1;
fprintf('The approximation of PI is %f\n', sum(monte_carlo) / input_times * 4);

