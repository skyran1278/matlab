function data = filename_to_array(filename, total_col, array_col, headlines)
%
% 適用於被動控制給的 file_input.
%
% @since 3.1.0
% @param {string} [filename] 檔案名稱.
% @param {number} [total_col] 總共有幾欄.
% @param {number} [array_col] 要回傳第幾欄.
% @param {number} [headlines] 忽略標題.
% @return {array} [data] 加速度歷時資料.
% @see ignore_headlines
%

    if nargin == 3
        headlines = 0;
    end

    fileID = fopen((filename + ".txt"), 'r');

    ignore_headlines(fileID, headlines);

    repeat_f = repmat('%f', 1, total_col);

    A = fscanf(fileID, repeat_f, [total_col Inf]).';

    fclose(fileID);

    data = A(:, array_col);

end
