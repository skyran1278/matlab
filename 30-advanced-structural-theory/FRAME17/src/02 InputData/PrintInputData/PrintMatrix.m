function [] = PrintMatrix(FILEID, TITLE, MATRIX, FORMAT)
% �g�J TITLE �P MATRIX �� FILEID

[rowLength, colLength] = size(MATRIX);

% ���²�檽ı���g�k
% for col = 1 : colLength

%     % �p�ƾ�
%     fprintf(FILEID, '%d', col);

%     for row = 1 : rowLength
%         fprintf(FILEID, ' ');
%         fprintf(FILEID, '%f', MATRIX(row, col));
%     end

%     fprintf(FILEID, '\n');
% end

index = 1 : colLength;

indexMatrix = [index; MATRIX];

fprintf(FILEID, TITLE);
fprintf(FILEID, '\n');

% fprintf �@�C�@�C�L
% �o�Ӥ�k�n���x matlab �� function �~�����ı
fprintf(FILEID, ['%d\t', repmat(FORMAT, 1, rowLength), '\n'], indexMatrix);

fprintf(FILEID, '\n');

end
