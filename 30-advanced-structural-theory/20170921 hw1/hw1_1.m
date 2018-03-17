%%
% 消除前一次作業
clc; clear; close all;

% 題目給定
% 換算成 matlab 弧度
theta = 30 * pi / 180;

%假設 h 為 1 單位
h = 1;

% 給定 delta 為 0 ~ 2.2 連續的值
% delta 為矩陣，之後的計算需要用矩陣運算
delta = 0 : 0.01 : 2.2;

L = h / sin(theta);
Lprum = sqrt((h - delta) .^ 2 + (L * cos(theta)) .^ 2 );

epsilon = (L - Lprum) ./ L;

% Ea * epsilon
PDivideEaDivideA1 = 2 .* epsilon .* (h - delta) ./ Lprum;

% Ea * epsilon + 4 * Ea * epsilon ^ 3
PDivideEaDivideA2 = 2 .* (epsilon + 4 .* epsilon .^ 3) .* (h - delta) ./ Lprum;

% 畫圖
plot(delta / h, PDivideEaDivideA1, 'k-', delta / h, PDivideEaDivideA2, 'r--');

%%
% 驗證題目給定的點 delta / h = 0.3
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
% 加上圖例

title('P / (Ea * A) 與 delta / h 關係圖');

legend('linear', 'nonlinear', 'linearPoint', 'nonlinearPoint', 'location', 'NorthEast');

xlabel('delta / h');
ylabel('P / (Ea * A)');
