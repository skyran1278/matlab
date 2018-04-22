function data = filename_to_array(filename)
%
% 適用於被動控制給的 file_input.
%
% @since 2.0.0
% @param {string} [filename] 檔案名稱.
% @param {number} [array_col] 要回傳第幾欄.
% @return {array} [data] 加速度歷時資料.
% @see dependencies
%

    headlines = 1;

    fileID = fopen([filename '.txt'], 'r');

    ignore_headlines(fileID, headlines);

    A = fscanf(fileID, '%f %f', [2 Inf]).';

    fclose(fileID);

    data = A;

end
