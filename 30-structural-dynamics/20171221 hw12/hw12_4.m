clc; clear; close all;

beta1 = - 0.563;
beta2 = - 1.402;

t = 0 : 0.01 : 1;

seta1 = t;
seta2 = t .^ 2;

phi1 = seta1 + beta1 * seta2;
phi2 = seta1 + beta2 * seta2;

subplot(2,1,1);
plot(t, phi1, t, seta1, '--', t, beta1 * seta2, '--');
xlabel('L');
ylabel('\Phi');
legend('', 'x/L', [num2str(beta1) '(x/L)^2'])
% set(gca, 'ytick', [0 1 2]);
set(get(gca, 'Title'), 'String', 'first mode shape');

subplot(2,1,2);
plot(t, phi2, t, seta1, '--', t, beta2 * seta2, '--');
xlabel('L');
ylabel('\Phi');
legend('', 'x/L', [num2str(beta2) '(x/L)^2'])
% set(gca, 'ytick', [0 1 2]);
set(get(gca, 'Title'), 'String', 'second mode shape');