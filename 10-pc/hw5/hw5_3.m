clc; clear; close all;

El_Centro_EW = filename_to_array('El Centro_EW(200Hz)', 1, 1, 0);

% TCU068_Z = filename_to_array('TCU068', 4, 2, 11);
TCU068_NS = filename_to_array('TCU068', 4, 3, 11);
TCU068_EW = filename_to_array('TCU068', 4, 4, 11);


El_Centro_EW_normalize = El_Centro_EW / max(El_Centro_EW) * 0.32;
TCU068_NS_normalize = TCU068_NS / max(TCU068_NS) * 0.32;
TCU068_EW_normalize = TCU068_EW / max(TCU068_EW) * 0.32;

fileID = fopen('El_Centro.txt', 'w');
fprintf(fileID, '%f\n', El_Centro_EW_normalize);
fclose(fileID);

fileID = fopen('TCU068_NS.txt', 'w');
fprintf(fileID, '%f\n', TCU068_NS_normalize);
fclose(fileID);

fileID = fopen('TCU068_EW.txt', 'w');
fprintf(fileID, '%f\n', TCU068_EW_normalize);
fclose(fileID);

