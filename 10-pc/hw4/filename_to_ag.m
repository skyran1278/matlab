function ag = filename_to_ag(filename, ag_col)
%
% 適用於被動控制給的 file_input.
%
% @since 1.0.0
% @param {string} [filename] 檔案名稱.
% @param {number} [ag_col] 要回傳第幾欄.
% @return {array} [ag] 加速度歷時資料.
% @see dependencies
%

    headlines = 11;

    fileID = fopen((filename + ".txt"), 'r');

    ignore_headlines(fileID, headlines);

    A = fscanf(fileID, '%f %f %f %f', [4 Inf]).';

    fclose(fileID);

    ag = A(:, ag_col);

end
