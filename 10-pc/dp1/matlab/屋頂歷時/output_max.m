clc; clear; close all;

write_response(1, 6);
write_response(2, 7);
write_response(3, 8);
write_response(4, 11);
write_response(5, 12);
write_response(6, 13);

function [] = write_response(sheet, cells)

    RF = xlsread('timeHistory.xlsx', sheet, 'A:I');

    RF(:, 6) = RF(:, 6) - RF(:, 2);
    RF(:, 7) = RF(:, 7) - RF(:, 3);

    RF = abs(RF);

    acceleration = max(max(RF(:, [4 5])));
    displacement = max(max(RF(:, [6 7])));
    velocity = max(max(RF(:, [8 9])));

    xlswrite('屋頂最大反應.xlsx', displacement, ['E' num2str(cells) ':E' num2str(cells)]);
    xlswrite('屋頂最大反應.xlsx', velocity, ['H' num2str(cells) ':H' num2str(cells)]);
    xlswrite('屋頂最大反應.xlsx', acceleration, ['K' num2str(cells) ':K' num2str(cells)]);

end

