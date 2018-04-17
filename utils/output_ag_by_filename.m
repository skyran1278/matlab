function ag = output_ag_by_filename(filename)
    NS = 3;
    fileID = fopen((filename + ".txt"), 'r');
    ignore_headlines(fileID, 11);
    A = fscanf(fileID, '%f %f %f %f', [4 Inf]).';
    fclose(fileID);
    ag = A(:, NS);
end
