clc; clear; close all;

m = 100; % kg
wn = 2 * pi * 0.5; % Hz
kxi = 0.03;

c = 2 * wn * kxi * m;
k = m * wn ^ 2;

wd = wn * sqrt(1 - kxi ^ 2);

t = 0 : 0.001 : 40;

p0 = 10; % p(t) = p0, where p0 = 10 N


%------------------
% (c)
%------------------
Hup = tf(1, [m, c, k]);

Hvp = tf([1 0], [m c k]);


%------------------
% (d)
%------------------
h = 1 / (m .* wd) .* exp(- kxi .* wn .* t) .* sin(wd .* t);

figure('Name','d');
plot(t, h);
title('Impulse response function');
xlabel('Time(seconds)');
ylabel('Amplitude');


%------------------
% (e)
%------------------
figure('Name','e');
h_tm = impulse(Hup, t);

plot(t, h_tm, ':', t, h,'--');
title('Impulse response function');
xlabel('Time(seconds)');
ylabel('Amplitude');
legend('matlab', 'equation');

%------------------
% (f)
%------------------
u = p0 ./ k .* (1 - exp(- kxi .* wn .* t) .* (cos(wd .* t) + kxi .* wn ./ wd .* sin(wd .* t)));
v = p0 ./ k .* (kxi .* wn .* exp(- kxi .* wn .* t) .* (cos(wd .* t) + kxi .* wn ./ wd .* sin(wd .* t)) - exp(- kxi .* wn .* t) .* (- wd .* sin(wd .* t) + kxi .* wn .* cos(wd .* t)));

figure('Name','f');
subplot(2, 1, 1);
plot(t, u);
title('Step response function');
xlabel('Time(seconds)');
ylabel('Displacement(m)');

subplot(2, 1, 2);
plot(t, v);
title('Step response function');
xlabel('Time(seconds)');
ylabel('Velocity');


%------------------
% (g)
%------------------
u_tm = p0 * step(Hup, t);
v_tm = p0 * step(Hvp, t);

figure('Name','g');
subplot(2, 1, 1);
plot(t, u, ':', t, u_tm,'--');
title('Step response function');
xlabel('Time(seconds)');
ylabel('Displacement(m)');
legend('equation', 'matlab');

subplot(2, 1, 2);
plot(t, v, ':', t, v_tm,'--');
title('Step response function');
xlabel('Time(seconds)');
ylabel('Velocity');
legend('equation', 'matlab');


%------------------
% (h)
%------------------
figure('Name','h');
plot(t, v_tm / p0, ':', t, h_tm,'--');
xlabel('Time(seconds)');
ylabel('Amplitude');
legend('g / 10', 'e');


%------------------
% (i)
%------------------
f = 0 : 0.001 : 10;
s = 1i .* 2 .* pi .* f;
Hu = 1 ./ (m .* s .^ 2 + c .* s + k);
Hv = s ./ (m .* s .^ 2 + c .* s + k);

figure('Name','i');
subplot(2, 2, 1);
plot(f, db(abs(Hu)));
title('displacement complex frequency response');
xlabel('frequency');
ylabel('magnitude(dB)');

subplot(2, 2, 2);
plot(f, db(abs(Hv)));
title('velocity complex frequency response');
xlabel('frequency');
ylabel('magnitude(dB)');

subplot(2, 2, 3);
plot(f, mod(angle(Hu) * 180 / pi + 180, 360) - 180);
title('displacement response phase angle');
xlabel('frequency');
ylabel('phase(deg)');

subplot(2, 2, 4);
plot(f, mod(angle(Hv) * 180 / pi + 180, 360) - 180);
title('displacement response phase angle');
xlabel('frequency');
ylabel('phase(deg)');


%------------------
% (j)
%------------------
Hu_m = squeeze(freqresp(Hup, 2 * pi * f));
Hv_m = squeeze(freqresp(Hvp, 2 * pi * f));

figure('Name','j');
subplot(2, 2, 1);
plot(f, db(abs(Hu)), ':', f, db(abs(Hu_m)),'--');
title('displacement complex frequency response');
xlabel('frequency');
ylabel('magnitude(dB)');
legend('equation', 'matlab');

subplot(2, 2, 2);
plot(f, db(abs(Hv)), ':', f, db(abs(Hv_m)),'--');
title('velocity complex frequency response');
xlabel('frequency');
ylabel('magnitude(dB)');
legend('equation', 'matlab');

subplot(2, 2, 3);
plot(f, mod(angle(Hu) * 180 / pi + 180, 360) - 180, ':', f, mod(angle(Hu_m) * 180 / pi + 180, 360) - 180,'--');
title('displacement response phase angle');
xlabel('frequency');
ylabel('phase(deg)');
legend('equation', 'matlab');

subplot(2, 2, 4);
plot(f, mod(angle(Hv) * 180 / pi + 180, 360) - 180, ':', f, mod(angle(Hv_m) * 180 / pi + 180, 360) - 180,'--');
title('displacement response phase angle');
xlabel('frequency');
ylabel('phase(deg)');
legend('equation', 'matlab');


%------------------
% (l)
%------------------
Ac = [0 1; -k/m -c/m];
Bc = [0; 1/m];
Cc = [eye(2); [-k/m -c/m]];
Dc = [0; 0; 1/m];
%==
sys = ss(Ac,Bc,Cc,Dc)

%------------------
% Form transfer function
% sys is a 3 x 1 system, in which the first, second, and third outputs are
% displacement, velocity, and acceleration.
%------------------
Hup_ss = tf(sys(1,:));
Hvp_ss = tf(sys(2,:));

%------------------
% Transfer function
%------------------
Hu_fss = squeeze(freqresp(sys(1, :), 2 * pi * f));
Hv_fss = squeeze(freqresp(sys(2, :), 2 * pi * f));
%==

figure('Name','l');
subplot(2, 2, 1);
plot(f, db(abs(Hu_fss)), ':', f, db(abs(Hu_m)),'--');
title('displacement complex frequency response');
xlabel('frequency');
ylabel('magnitude(dB)');
legend('l', 'j');

subplot(2, 2, 2);
plot(f, db(abs(Hv_fss)), ':', f, db(abs(Hv_m)),'--');
title('velocity complex frequency response');
xlabel('frequency');
ylabel('magnitude(dB)');
legend('l', 'j');

subplot(2, 2, 3);
plot(f, mod(angle(Hu_fss) * 180 / pi + 180, 360) - 180, ':', f, mod(angle(Hu_m) * 180 / pi + 180, 360) - 180,'--');
title('displacement response phase angle');
xlabel('frequency');
ylabel('phase(deg)');
legend('l', 'j');

subplot(2, 2, 4);
plot(f, mod(angle(Hv_fss) * 180 / pi + 180, 360) - 180, ':', f, mod(angle(Hv_m) * 180 / pi + 180, 360) - 180,'--');
title('displacement response phase angle');
xlabel('frequency');
ylabel('phase(deg)');
legend('l', 'j');
