function [] = PrintMatrix(FILEID, TITLE, MATRIX, FORMAT)
% 寫入 TITLE 與 MATRIX 到 FILEID

[rowLength, colLength] = size(MATRIX);

% 比較簡單直覺的寫法
% for col = 1 : colLength

%     % 計數器
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

% fprintf 一列一列印
% 這個方法要熟悉 matlab 的 function 才比較直覺
fprintf(FILEID, ['%d\t', repmat(FORMAT, 1, rowLength), '\n'], indexMatrix);

fprintf(FILEID, '\n');

end
