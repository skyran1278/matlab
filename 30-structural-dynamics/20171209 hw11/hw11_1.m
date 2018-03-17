clc; clear; close all;

u1 = [0 0.667 1];
u2 = [0 -0.997 1];

story = [0 1 2];

subplot(1,2,1);
plot(u1, story);
xlabel('displacement');
ylabel('story');
set(gca, 'ytick', [0 1 2]);
set(get(gca, 'Title'), 'String', 'first mode shape');

subplot(1,2,2);
plot(u2, story);
xlabel('displacement');
ylabel('story');
set(gca, 'ytick', [0 1 2]);
set(get(gca, 'Title'), 'String', 'second mode shape');
