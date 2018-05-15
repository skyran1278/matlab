function mat = ReadMatrix(IREAD, row, col)
% for function INPUT
% row 和 col 互換，目前還不清楚為什麼要這樣做。感覺不太直覺。

mat = zeros(row, col);

for j = 1 : col
    line = fgets(IREAD);
    num = str2num(line);
    mat(:, j) = num(2 : row + 1);
end

end
