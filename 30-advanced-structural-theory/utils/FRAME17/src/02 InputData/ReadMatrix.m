function mat = ReadMatrix(IREAD, row, col)
% for function INPUT
% row �M col �����A�ثe�٤��M��������n�o�˰��C�Pı���Ӫ�ı�C

mat = zeros(row, col);

for j = 1 : col
    line = fgets(IREAD);
    num = str2num(line);
    mat(:, j) = num(2 : row + 1);
end

end
