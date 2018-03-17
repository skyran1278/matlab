function HeadLine(ID, IREAD)
% 這是用來忽略空白列與註解列

while ~feof(IREAD)
    temp = fgets(IREAD);
    if ~isempty(temp) && temp(1) == ID
        return
    end
end

end
