%%
% �����e�@���@�~
clc; clear; close all;

% �D�ص��w
% ���⦨ matlab ����
theta = 30 * pi / 180;

%���] h �� 1 ���
h = 1;

% ���w delta �� 0 ~ 2.2 �s�򪺭�
% delta ���x�}�A���᪺�p��ݭn�ίx�}�B��
delta = 0 : 0.01 : 2.2;

L = h / sin(theta);
Lprum = sqrt((h - delta) .^ 2 + (L * cos(theta)) .^ 2 );

epsilon = (L - Lprum) ./ L;

% Ea * epsilon
PDivideEaDivideA1 = 2 .* epsilon .* (h - delta) ./ Lprum;

% Ea * epsilon + 4 * Ea * epsilon ^ 3
PDivideEaDivideA2 = 2 .* (epsilon + 4 .* epsilon .^ 3) .* (h - delta) ./ Lprum;

% �e��
plot(delta / h, PDivideEaDivideA1, 'k-', delta / h, PDivideEaDivideA2, 'r--');

%%
% �����D�ص��w���I delta / h = 0.3
hold on

LprumPoint = sqrt((h - 0.3) ^ 2 + (L * cos(theta)) ^ 2 );
epsilonPoint = (L - LprumPoint) / L;

linearPoint = 2 * (L - LprumPoint) / L * (h - 0.3) / LprumPoint;
nonlinearPoint = 2 * (epsilonPoint + 4 * epsilonPoint ^ 3) * (h - 0.3) / LprumPoint;

plot(0.3, linearPoint,'c*', 0.3, nonlinearPoint, 'r*')

linearPointValue = num2str(linearPoint);
text(0.3,linearPoint,linearPointValue,'HorizontalAlignment','left');

nonlinearPointValue = num2str(nonlinearPoint);
text(0.3, nonlinearPoint, nonlinearPointValue, 'HorizontalAlignment', 'right');

%%
% �[�W�Ϩ�

title('P / (Ea * A) �P delta / h ���Y��');

legend('linear', 'nonlinear', 'linearPoint', 'nonlinearPoint', 'location', 'NorthEast');

xlabel('delta / h');
ylabel('P / (Ea * A)');
