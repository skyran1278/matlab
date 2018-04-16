clc; clear; close all;




figure;

timertitle = tic;
for index = 1 : 100
    title('i am paul');
end
toc(timertitle)

figure;

timerSet = tic;
for index = 1 : 100
    set(get(gca, 'Title'), 'String', 'i am paul');
end
toc(timerSet)

figure;
for
timertitle = tic;
title('i am paul');
toc(timertitle)

figure;

timerSet = tic;
set(get(gca, 'Title'), 'String', 'i am paul');
toc(timerSet)

figure;

timertitle = tic;
for index = 1 : 100
    title('i am paul');
end
toc(timertitle)

