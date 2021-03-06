clc; clear; close all;

period = filename_to_array('I-ELC270_gal_l00Hz', 2, 1);
ag = filename_to_array('I-ELC270_gal_l00Hz', 2, 2);

ag = ag / max(abs(ag)) * 0.4;

tn = 0.01 : 0.01 : 5;
tn_length = length(tn);
acceleration = zeros(1, tn_length);

for index = 1 : tn_length

    [~, ~, a_array] = newmark_beta(ag, 0.01, 0.05, tn(index), 'average');

    acceleration(1, index) = max(abs(a_array));

end

acceleration(tn == 2.5)
figure;
plot(tn, acceleration);
xlabel('T(sec)');
ylabel('SaD(g)');

fileID = fopen('ELC.txt', 'w');
fprintf(fileID, '%f \r\n', ag);
fclose(fileID);
% clc; clear; close all;

% ag = filename_to_array('I-ELC270_gal_l00Hz', 2, 2);

% tn = 0.01 : 0.01 : 5;
% tn_length = length(tn);
% acceleration = zeros(1, tn_length);

% for index = 1 : tn_length

%     [~, ~, a_array] = newmark_beta(ag, 0.01, 0.05, tn(index), 'average');

%     acceleration(1, index) = max(abs(a_array));

% end

% acceleration_normal = acceleration / acceleration(1, 1) * 0.4;
% acceleration_normal(tn == 2.5)
% figure;
% plot(tn, acceleration_normal);
% xlabel('T(sec)');
% ylabel('SaD(g)');
