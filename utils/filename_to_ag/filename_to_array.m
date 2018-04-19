function data = filename_to_array(filename, array_col)
%
% �A�Ω�Q�ʱ���� file_input.
%
% @since 2.0.0
% @param {string} [filename] �ɮצW��.
% @param {number} [array_col] �n�^�ǲĴX��.
% @return {array} [data] �[�t�׾��ɸ��.
% @see dependencies
%

    headlines = 11;

    fileID = fopen((filename + ".txt"), 'r');

    ignore_headlines(fileID, headlines);

    A = fscanf(fileID, '%f %f %f %f', [4 Inf]).';

    fclose(fileID);

    data = A(:, array_col);

end
