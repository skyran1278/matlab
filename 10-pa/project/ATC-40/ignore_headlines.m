function [] = ignore_headlines(fileID, headlines)
%
% 忽略標題.
%
% @since 1.0.0
% @param {number} [fileID] fileID.
% @param {number} [headlines] 要忽略的行數.
%

    for index = 1 : headlines
        fgetl(fileID);
    end
end
