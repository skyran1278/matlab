clc; clear; close all;

% syms u(x) u_sol(x) x

% format compact

% eqn = diff(2 * 10^7 *(x + 1) * diff(u, x), x) + 24 * (x + 1) == 0;

% conds = u(2) == 0;

% u_sol = dsolve(eqn, conds)
% stress_sol = diff(u_sol, x) * 2 * 10^7
% simplify(u_sol)
% % t = 0 : 0.01 : 2;

% % u_sol(t)

% % plot(t, u_sol(t))

% int(10^-7 * (-12 * x^2 -24 * x) / (x + 1))

x = 0 : 0.01 : 2;

u_linear = 10^-7 * (30 - 15 * x);
stress_linear = -30 * ones(1, length(x));

u_quadratic = 10^-7 * (28.37 - 9.273 * x - 2.455 * x.^2);
stress_quadratic = -18.546 - 9.82 * x;

u_exact = (-6 * (x + 1).^2 - 8 * log(x + 1) + 54 + 8 * log(3)) / (2 * 10^7);
stress_exact = -8 ./ (x + 1) - 12 * x - 12;

figure;
plot(x, u_linear, '--', x, u_quadratic, '--', x, u_exact, '--');
legend('linear', 'quadratic', 'exact');
xlabel('x (m)');
ylabel('disp (m)');

figure;
plot(x, stress_linear, '--', x, stress_quadratic, '--', x, stress_exact, '--');
legend('linear', 'quadratic', 'exact');
xlabel('x (m)');
ylabel('stress (kN/m^2)');
