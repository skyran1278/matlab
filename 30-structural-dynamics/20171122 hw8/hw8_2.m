clc; clear; close all;

m = 100; % kg
wn = 2 * pi * 0.5; % Hz
kxi = 0.03;

c = 2 * wn * kxi * m;
k = m * wn ^ 2;

wd = wn * sqrt(1 - kxi ^ 2);


%------------------
% (c)
%------------------
H_w_z_dotdot_p = tf(-m, [m, c, k]);

H_w_dot_z_dotdot_p = tf([-m 0], [m c k]);

H_u_dotdot_z_dotdot_p = tf([c k], [m c k]);


%------------------
% (e)
%------------------
f = 0 : 0.001 : 10;
s = 1i .* 2 .* pi .* f;

H_w_z_dotdot = -1 ./ (m .* s .^ 2 + c .* s + k);
H_w_dot_z_dotdot = -s ./ (m .* s .^ 2 + c .* s + k);
H_u_dotdot_z_dotdot = (c .* s + k) ./ (m .* s .^ 2 + c .* s + k);

figure('Name','e');
subplot(2, 3, 1);
plot(f, db(abs(H_w_z_dotdot)));
title('displacement complex frequency response');
xlabel('frequency');
ylabel('magnitude(dB)');

subplot(2, 3, 2);
plot(f, db(abs(H_w_dot_z_dotdot)));
title('velocity complex frequency response');
xlabel('frequency');
ylabel('magnitude(dB)');

subplot(2, 3, 3);
plot(f, db(abs(H_u_dotdot_z_dotdot)));
title('acceleration complex frequency response');
xlabel('frequency');
ylabel('magnitude(dB)');

subplot(2, 3, 4);
plot(f, mod(angle(H_w_z_dotdot) * 180 / pi + 180, 360) - 180);
title('displacement response phase angle');
xlabel('frequency');
ylabel('phase(deg)');

subplot(2, 3, 5);
plot(f, mod(angle(H_w_dot_z_dotdot) * 180 / pi + 180, 360) - 180);
title('displacement response phase angle');
xlabel('frequency');
ylabel('phase(deg)');

subplot(2, 3, 6);
plot(f, mod(angle(H_u_dotdot_z_dotdot) * 180 / pi + 180, 360) - 180);
title('acceleration response phase angle');
xlabel('frequency');
ylabel('phase(deg)');

H_w_z_dotdot_m = squeeze(freqresp(H_w_z_dotdot_p, 2 * pi * f));
H_w_dot_z_dotdot_m = squeeze(freqresp(H_w_dot_z_dotdot_p, 2 * pi * f));
H_u_dotdot_z_dotdot_m = squeeze(freqresp(H_u_dotdot_z_dotdot_p, 2 * pi * f));


figure('Name','e');
subplot(2, 3, 1);
plot(f, db(abs(H_w_z_dotdot_m)));
title('displacement complex frequency response');
xlabel('frequency');
ylabel('magnitude(dB)');

subplot(2, 3, 2);
plot(f, db(abs(H_w_dot_z_dotdot_m)));
title('velocity complex frequency response');
xlabel('frequency');
ylabel('magnitude(dB)');

subplot(2, 3, 3);
plot(f, db(abs(H_u_dotdot_z_dotdot_m)));
title('acceleration complex frequency response');
xlabel('frequency');
ylabel('magnitude(dB)');

subplot(2, 3, 4);
plot(f, mod(angle(H_w_z_dotdot_m) * 180 / pi + 180, 360) - 180);
title('displacement response phase angle');
xlabel('frequency');
ylabel('phase(deg)');

subplot(2, 3, 5);
plot(f, mod(angle(H_w_dot_z_dotdot_m) * 180 / pi + 180, 360) - 180);
title('velocity response phase angle');
xlabel('frequency');
ylabel('phase(deg)');

subplot(2, 3, 6);
plot(f, mod(angle(H_u_dotdot_z_dotdot_m) * 180 / pi + 180, 360) - 180);
title('acceleration response phase angle');
xlabel('frequency');
ylabel('phase(deg)');

%------------------
% (f)
%------------------
Ac = [0 1; -k/m -c/m];
Bc = [0; -1];
Cc = [eye(2); [-k/m -c/m]];
Dc = [0; 0; 0];

%------------------
% (g)
%------------------
sys = ss(Ac,Bc,Cc,Dc)

%------------------
% Transfer function
%------------------
H_w_z_dotdot_fss = squeeze(freqresp(sys(1, :), 2 * pi * f));
H_w_dot_z_dotdot_fss = squeeze(freqresp(sys(2, :), 2 * pi * f));
H_u_dotdot_z_dotdot_fss = squeeze(freqresp(sys(3, :), 2 * pi * f));
%==

figure('Name','g');
subplot(2, 3, 1);
plot(f, db(abs(H_w_z_dotdot_m)), ':', f, db(abs(H_w_z_dotdot_fss)),'--');
title('displacement complex frequency response');
xlabel('frequency');
ylabel('magnitude(dB)');
legend('e', 'g');

subplot(2, 3, 2);
plot(f, db(abs(H_w_dot_z_dotdot_m)), ':', f, db(abs(H_w_dot_z_dotdot_fss)),'--');
title('velocity complex frequency response');
xlabel('frequency');
ylabel('magnitude(dB)');
legend('e', 'g');

subplot(2, 3, 3);
plot(f, db(abs(H_u_dotdot_z_dotdot_m)), ':', f, db(abs(H_u_dotdot_z_dotdot_fss)),'--');
title('acceleration complex frequency response');
xlabel('frequency');
ylabel('magnitude(dB)');
legend('e', 'g');


subplot(2, 3, 4);
plot(f, mod(angle(H_w_z_dotdot_m) * 180 / pi + 180, 360) - 180, ':', f, mod(angle(H_w_z_dotdot_fss) * 180 / pi + 180, 360) - 180,'--');
title('displacement complex frequency response');
xlabel('frequency');
ylabel('phase(deg)');
legend('e', 'g');

subplot(2, 3, 5);
plot(f, mod(angle(H_w_dot_z_dotdot_m) * 180 / pi + 180, 360) - 180, ':', f, mod(angle(H_w_dot_z_dotdot_fss) * 180 / pi + 180, 360) - 180,'--');
title('velocity complex frequency response');
xlabel('frequency');
ylabel('phase(deg)');
legend('e', 'g');

subplot(2, 3, 6);
plot(f, mod(angle(H_u_dotdot_z_dotdot_m) * 180 / pi + 180, 360) - 180, ':', f, mod(angle(H_u_dotdot_z_dotdot_fss) * 180 / pi + 180, 360) - 180,'--');
title('acceleration complex frequency response');
xlabel('frequency');
ylabel('phase(deg)');
legend('e', 'g');
