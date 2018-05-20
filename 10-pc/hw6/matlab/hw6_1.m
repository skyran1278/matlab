clc; clear; close all;

filename = 'VD tests(revised).xlsx';
sheet = 1;

disp005 = xlsread(filename, sheet, 'B3:B3739');
force005 = xlsread(filename, sheet, 'C3:C3739');

disp01 = xlsread(filename, sheet, 'E3:E3957');
force01 = xlsread(filename, sheet, 'F3:F3957');

disp03 = xlsread(filename, sheet, 'H3:H3773');
force03 = xlsread(filename, sheet, 'I3:I3773');

disp05 = xlsread(filename, sheet, 'K3:K4002');
force05 = xlsread(filename, sheet, 'L3:L4002');

disp1 = xlsread(filename, sheet, 'N3:N3759');
force1 = xlsread(filename, sheet, 'O3:O3759');

% log(force005) = log(C) + alpha_ * log(diff(disp005))

% plot([dis(disp005, 0.05) dis(disp01, 0.1) dis(disp03, 0.3) dis(disp05, 0.5) dis(disp1, 1)], [force(force005) force(force01) force(force03) force(force05) force(force1)], 'ko');

x = [dis(disp005, 0.05) dis(disp01, 0.1) dis(disp03, 0.3) dis(disp05, 0.5) dis(disp1, 1)].';
y = [force(force005) force(force01) force(force03) force(force05) force(force1)].';

alpha_ = 0.687;
lnC = 5.9019;

vel = 0 : 0.0001 : 0.25;

f = exp(5.9019) * vel .^ 0.687;

figure;
theory = plot(vel, f, 'k');
hold on;
test_data = plot(x, y, 'r*');
hold on;
error_range = plot(vel, 1.15 * f, 'r:', vel, 0.85 * f, 'r:');
title('');
xlabel('Velocity (mm/sec)');
ylabel('Force (tf)');
legend([theory, test_data, error_range(1)], '²z½×­È', '¸ÕÅç­È', '15%»~®t½d³ò', 'Location', 'southeast');

function output = dis(input, f)
    output = max(abs(diff(input) * f));
end

function output = force(input)
    output = max(abs(input));
end
