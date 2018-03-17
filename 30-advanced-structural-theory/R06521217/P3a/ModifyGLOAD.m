function GLOAD = ModifyGLOAD(GLOAD, IDND)
%ModifyGLOAD - Description
%
% Syntax: GLOAD = ModifyGLOAD(COOR, FORMAT, IDBC, LM, NEQ, NSEC, ...
    % DELTA, FTYPE, IDND, LUNIT, NFIX, PROP, ...
    % ELFOR, FUNIT, IFORCE, NBC, NMAT, SECT, ...
    % EXLD, GLK, IPR, NCO, NNE, TITLE, ...
    % FEF, GLOAD, IREAD, NDE, NNOD, VECTY, ...
    % FILENAME, ID, ITP, NDN, NSBAND)
%
% Long description

PT = 3;

if IDND(2, PT) > 0
    GLOAD(IDND(2, PT)) = GLOAD(IDND(2, PT)) + (-200);
end

end