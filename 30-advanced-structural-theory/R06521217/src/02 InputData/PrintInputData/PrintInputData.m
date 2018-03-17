function [] = PrintInputData(FILENAME, TITLE, FUNIT, LUNIT, NNOD, NBC, NMAT, NSEC, ITP, IFORCE, NNE, COOR, NFIX, EXLD, IDBC, VECTY, FEF, PROP, SECT)
%PrintInputData - write out the input data to check
%
% Syntax: [] = PrintInputData(FILENAME, TITLE, FUNIT, LUNIT, NNOD, NBC, NMAT, NSEC, ITP, IFORCE, NNE, COOR, NFIX, EXLD, IDBC, VECTY, FEF, PROP, SECT)
%
% Long description
IWRITE = fopen([FILENAME '.opt'], 'w');

fprintf(IWRITE, '%s', TITLE);
fprintf(IWRITE, '%s', FUNIT);
fprintf(IWRITE, '%s', LUNIT);
fprintf(IWRITE, '\n');

fprintf(IWRITE, '* NNOD NBC NMAT NSEC ITP NNE IFORCE');
fprintf(IWRITE, '\n');
fprintf(IWRITE, '%d %d %d %d %d %d %d', NNOD, NBC, NMAT, NSEC, ITP, NNE, IFORCE);
fprintf(IWRITE, '\n');
fprintf(IWRITE, '\n');

PrintMatrix(IWRITE, '* COOR (m)', COOR, '%.3f\t');

PrintMatrix(IWRITE, '* NFIX', NFIX, '%d\t');

PrintMatrix(IWRITE, '* External Load (kN)', EXLD, '%.3f\t');

PrintMatrix(IWRITE, '* IDBC', IDBC, '%d\t');

% VECTY
if ITP == 6
    PrintMatrix(IWRITE, '* VECTY', VECTY, '%.3f\t');
end

% IFORCE
if IFORCE == 2
    PrintMatrix(IWRITE, '* FEF', FEF, '%.3f\t');
end


PrintMatrix(IWRITE, '* PROP', PROP, '%.3f\t');

PrintMatrix(IWRITE, '* SECT', SECT, '%.3f\t');

end
