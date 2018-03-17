% 消除前一次作業
clc; clear; close all;

t1 = 0 : 0.0001 : 1;
t2 = 1.0001 : 0.0001 : 4;

TnRatio = [0.25 0.5 1 1.5]; % td / Tn
WnRatio = TnRatio * 2 * pi; % td * Wn

figureTimes = length(TnRatio);

maxResponse = zeros(1, figureTimes);
maxTime = zeros(1, figureTimes);
minResponse = zeros(1, figureTimes);
minTime = zeros(1, figureTimes);

figure;

for index = 1 : figureTimes
  R = WnRatio(index);

  if index ~= 2
    R1 = R * (R * sin(pi * t1) - pi * sin(R * t1)) / (R ^ 2 - pi ^ 2);
    R2 = R * pi .* (sin(R .* (t2 - 1)) + sin(R .* t2)) ./ (pi ^ 2 - R ^ 2);
  else
    R1 = 0.5 .* (sin(R .* t1) - R .* t1 .* cos(R .* t1));
    R2 = -pi / 2 .* cos(R .* t2);
  end

  Time = [t1 t2];
  ResponseRatio = [R1 R2];

  subplot(2, 2, index);
  plot(Time, ResponseRatio);
  title(['td / Tn = ', num2str(TnRatio(index))]);
  axis([0 4 -2 2])
  xlabel('Non-dimensional Time t/td');
  ylabel('Response Ratio');

  [maxResponse(index), maxPosition] = max(ResponseRatio);
  maxTime(index) = Time(maxPosition);
  [minResponse(index), minPosition] = min(ResponseRatio);
  minTime(index) = Time(minPosition);

end

[maxResponse; maxTime]
% max
% 0.9428    1.5708    1.7321    1.5000
% 1.5000    1.0000    0.6667    0.5000

[minResponse; minTime]
% min
% -0.9428   -1.5708   -1.3333   -0.0000
% 3.5000    2.0000    1.2500    3.6614

