function [] = ignore_headlines(fileID, headlines)
%
% �������D.
%
% @since 1.0.0
% @param {number} [fileID] fileID.
% @param {number} [headlines] �n���������.
%

    for index = 1 : headlines
        fgetl(fileID);
    end
end
