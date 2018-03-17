function [] = CalStressRatio(COOR, FORMAT, IDBC, LM, NEQ, NSEC, ...
    DELTA, FTYPE, IDND, LUNIT, NFIX, PROP, ...
    ELFOR, FUNIT, IFORCE, NBC, NMAT, SECT, ...
    EXLD, GLK, IPR, NCO, NNE, TITLE, ...
    FEF, GLOAD, IREAD, NDE, NNOD, VECTY, ...
    FILENAME, ID, ITP, NDN, NSBAND)
%CalStressRatio - Description
%
% Syntax: [] = CalStressRatio(COOR, FORMAT, IDBC, LM, NEQ, NSEC, ...
    % DELTA, FTYPE, IDND, LUNIT, NFIX, PROP, ...
    % ELFOR, FUNIT, IFORCE, NBC, NMAT, SECT, ...
    % EXLD, GLK, IPR, NCO, NNE, TITLE, ...
    % FEF, GLOAD, IREAD, NDE, NNOD, VECTY, ...
    % FILENAME, ID, ITP, NDN, NSBAND)
%
% Long description

fprintf('*Stress Ratio \n');

for IB = 1 : NBC

    P = ELFOR(3, IB);

    [~, RL] = ROTATION(COOR, VECTY, IDBC, IB, ITP, NCO, NDE);

    E = PROP(1, IDBC(3, IB)); % Young's modulus
    SigmaY = PROP(3, IDBC(3, IB));

    A = SECT(1, IDBC(4, IB)); % cross-section area
    Iz = SECT(2, IDBC(4, IB)); % moments of inertia Iz


    if P >= 0
        Py = A * SigmaY;
        SR = P / Py;
    else
        Pcr = (pi ^ 2) * E * Iz / (RL ^ 2);
        SR = - P / Pcr;
    end

    fprintf('element %i stress ratio : %f\n', IB, SR);

end

end