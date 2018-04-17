function [] = ignore_headlines(fileID, headlines)
    for index = 1 : headlines
        fgetl(fileID);
    end
end
