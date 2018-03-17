% 消除前一次作業
clc; clear; close all;

% 需要準確區分矩陣乘法 .* 逐元素 * 一般矩陣乘法
syms a b c d e f g h k l m n o p q r s t u v w x y z;


D = [
  a b 0 0;
  c d 0 0;
  0 0 e f;
  0 0 g h;
];

D1 = D(1 : 2, 1 : 2);
D2 = D(3 : 4, 3 : 4);

C = [
  k l m n;
  o p q r;
];

C1 = C(:, 1 : 2);
C2 = C(:, 3 : 4);

Dr = C * D * C.';

DrPlus = C1 * D1 * C1.' + C2 * D2 * C2.'

Dr == DrPlus