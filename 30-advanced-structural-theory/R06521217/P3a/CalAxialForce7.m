function [] = CalAxialForce7(ELFOR)
%CalAxialForce7 - Description
%
% Syntax: [] = CalAxialForce7(COOR, FORMAT, IDBC, LM, NEQ, NSEC, ...
    % DELTA, FTYPE, IDND, LUNIT, NFIX, PROP, ...
    % ELFOR, FUNIT, IFORCE, NBC, NMAT, SECT, ...
    % EXLD, GLK, IPR, NCO, NNE, TITLE, ...
    % FEF, GLOAD, IREAD, NDE, NNOD, VECTY, ...
    % FILENAME, ID, ITP, NDN, NSBAND)
%
% Long description

PT = 3;

axforce = ELFOR(4, 7);

fprintf('Axial Force of Member 7 is %f when the concentrated load is applied at point %i \n', axforce, PT);

end