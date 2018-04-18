function ag = filename_to_ag(filename)
%
% �A�Ω�Q�ʱ���� file_input.
%
% @since 1.0.0
% @param {string} [filename] �ɮצW��.
% @return {array} [ag] �[�t�׾��ɸ��.
% @see dependencies
%

    headlines = 11;

    ag_col = 3;

    fileID = fopen((filename + ".txt"), 'r');

    ignore_headlines(fileID, headlines);

    A = fscanf(fileID, '%f %f %f %f', [4 Inf]).';

    fclose(fileID);

    ag = A(:, ag_col);

end
