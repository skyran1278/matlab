ag = filename_to_array('TCU052', 4, 4, 11);

ag_detrend = detrend(ag);

fileID = fopen('TCU052_detrend.txt', 'w');

fprintf(fileID, '%f\n', ag_detrend);

ag = filename_to_array('TCU072', 4, 4, 11);

ag_detrend = detrend(ag);

fileID = fopen('TCU072_detrend.txt', 'w');

fprintf(fileID, '%f\n', ag_detrend);
