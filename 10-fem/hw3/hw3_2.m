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

Kg = zeros(3);

for index = 1 : 2
    Kg([index, index + 1], [index, index + 1]) = Kg([index, index + 1], [index, index + 1]) + eval(['Ke' num2str(index)]);
end

Kg

fg = zeros(3, 1);

for index = 1 : 2
    fg([index, index + 1], 1) = fg([index, index + 1], 1) + eval(['fe' num2str(index)]);
end

fg

dg = zeros(3, 1);

dg([1 2], 1) = Kg([1 2], [1 2]) \ fg([1 2], 1);

r = Kg * dg - fg;


x1 = 0 : 0.01 : 2;

u_linear = 10^-7 * (30 - 15 * x1);

u_exact = (-6 * (x1 + 1).^2 - 8 * log(x1 + 1) + 54 + 8 * log(3)) / (2 * 10^7);

x2 = [0; 1; 2];

figure;
plot(x1, u_linear, x1, u_exact, x2, dg);
legend('linear', 'exact', 'fem');
xlabel('x (m)');
ylabel('disp (m)');
