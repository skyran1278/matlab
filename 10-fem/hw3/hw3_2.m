clc; clear; close all;

% const
Ee = 2e7; % kN/m2
unit_weighs = 24; %kN/m3
t_bar = 20; % kN/m2

% variable
syms x xe1 xe2

Ae = x + 1;

p = [1 x];

Me = [
    1 xe1;
    1 xe2;
];

Ne = simplify(p / Me);

Be = diff(Ne, x);

Ke = simplify(int(Be.' * Ae * Ee * Be, x, xe1, xe2));

Ke1 = subs(Ke, [xe1 xe2], [0, 1])
Ke2 = subs(Ke, [xe1 xe2], [1, 2])



b(x) = unit_weighs * (x + 1);

fe_omega = simplify(int(Ne.' * b(x), x, xe1, xe2));

fe_gamma = subs(Ne.' * Ae * t_bar, x, 0);

fe1 = subs(fe_omega + fe_gamma, [xe1 xe2], [0, 1])
fe2 = subs(fe_omega, [xe1 xe2], [1, 2])

K = zeros(3);

for index = 1 : 2
    K([index, index + 1], [index, index + 1]) = K([index, index + 1], [index, index + 1]) + eval(['Ke' num2str(index)]);
end

K

f = zeros(3, 1);

for index = 1 : 2
    f([index, index + 1], 1) = f([index, index + 1], 1) + eval(['fe' num2str(index)]);
end

f

d = zeros(3, 1)
d([1 2], 1) = K([1 2], [1 2]) \ f([1 2], 1)

r = K * d - f


t = 0 : 0.01 : 2;

u_linear = 10^-7 * (30 - 15 * t);

u_exact = (-6 * (t + 1).^2 - 8 * log(t + 1) + 54 + 8 * log(3)) / (2 * 10^7);

x = [0; 1; 2];

figure;
plot(t, u_linear, t, u_exact, x, d);
legend('linear', 'exact', 'fem');
xlabel('x (m)');
ylabel('disp (m)');
