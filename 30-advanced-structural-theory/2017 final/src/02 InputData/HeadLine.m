function HeadLine(ID, IREAD)
% �o�O�Ψө����ťզC�P���ѦC

while ~feof(IREAD)
    temp = fgets(IREAD);
    if ~isempty(temp) && temp(1) == ID
        return
    end
end

end
