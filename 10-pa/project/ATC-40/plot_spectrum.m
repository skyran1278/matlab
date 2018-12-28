clc; clear; close all;

pushover = 'pushover';

TCU068 = 'TCU068';

period = filename_to_array(TCU068, 2, 1); % s
ag = filename_to_array(TCU068, 2, 2) / 981; % g

pushover_sd = filename_to_array(pushover, 3, 1, 2); % cm
pushover_sa = filename_to_array(pushover, 3, 2, 2); % g

tn = 0.01 : 0.01 : 5;
tn_length = length(tn);
acceleration = zeros(1, tn_length);

time_interval = period(2) - period(1);

for index = 1 : tn_length

    [~, ~, a_array] = newmark_beta(ag, time_interval, 0.05, tn(index), 'average');

    acceleration(1, index) = max(abs(a_array));

end

figure;
plot(tn, acceleration);
title(filename);
xlabel('T(sec)');
ylabel('Sa(g)');


function output = pushover_curve(pushover)

end
