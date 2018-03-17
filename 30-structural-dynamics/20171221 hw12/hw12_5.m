clc; clear; close all;

t = 0 : 0.01 : 1;

beta1 = - 0.384;
beta2 = - 1.216;

seta1 = t .^ 2;
seta2 = t .^ 3;

phi1 = seta1 + beta1 * seta2;
phi2 = seta1 + beta2 * seta2;

subplot(2,1,1);
plot(t, phi1, t, seta1, '--', t, beta1 * seta2, '--');
xlabel('L');
ylabel('\Phi');
legend('', '(x/L)^3', [num2str(beta1) '(x/L)^3'])
set(get(gca, 'Title'), 'String', 'first mode shape');

subplot(2,1,2);
plot(t, phi2, t, seta1, '--', t, beta2 * seta2, '--');
xlabel('L');
ylabel('\Phi');
legend('', '(x/L)^3', [num2str(beta2) '(x/L)^3'])
set(get(gca, 'Title'), 'String', 'second mode shape');