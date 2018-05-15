function data = filename_to_array(filename, total_col, array_col, headlines)
%
% �A�Ω�Q�ʱ���� file_input.
%
% @since 3.1.0
% @param {string} [filename] �ɮצW��.
% @param {number} [total_col] �`�@���X��.
% @param {number} [array_col] �n�^�ǲĴX��.
% @param {number} [headlines] �������D.
% @return {array} [data] �[�t�׾��ɸ��.
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
