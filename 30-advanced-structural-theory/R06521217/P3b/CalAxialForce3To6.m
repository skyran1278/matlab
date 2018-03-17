function [GLOAD, GLK, DELTA, ELFOR] = CalAxialForce3To6(COOR, FORMAT, IDBC, LM, NEQ, NSEC, ...
    FTYPE, IDND, LUNIT, NFIX, PROP, ...
    FUNIT, IFORCE, NBC, NMAT, SECT, ...
    EXLD, IPR, NCO, NNE, TITLE, ...
    FEF, IREAD, NDE, NNOD, VECTY, ...
    FILENAME, ID, ITP, NDN, NSBAND)
%CalAxialForce3To6 - Description
%
% Syntax: [GLOAD, GLK, DELTA, ELFOR] = CalAxialForce3To6(COOR, FORMAT, IDBC, LM, NEQ, NSEC, ...
    % DELTA, FTYPE, IDND, LUNIT, NFIX, PROP, ...
    % ELFOR, FUNIT, IFORCE, NBC, NMAT, SECT, ...
    % EXLD, GLK, IPR, NCO, NNE, TITLE, ...
    % FEF, GLOAD, IREAD, NDE, NNOD, VECTY, ...
    % FILENAME, ID, ITP, NDN, NSBAND)
%
% Long description
for PT = 3 : 6

    % Form the global load vector GLOAD(NEQ) from the concentrated nodal loads
    % GLOAD(Array)：把集中力轉換成方程式型態
    GLOAD = LOAD(EXLD, IDND, NDN, NNOD, NEQ);

    if IDND(2, PT) > 0
        GLOAD(IDND(2, PT)) = GLOAD(IDND(2, PT)) + (-200);
    end

    % ^^* UP TO HERE  --- PROG 2 ^^*

    % Form the global stiffness matrix GLK(NEQ,NSBAND) and obtain the
    % equivalent nodal vector by assembling -(fixed-end forces) of each member
    % into the load vector.
    % GLK(Matrix)：Assemble Stiffness
    % GLOAD(Array)：FEF 修正集中力
    [GLK, GLOAD] = FORMKP(COOR, IDBC, VECTY, PROP, SECT, LM, FEF, GLOAD, NNOD, NBC, NMAT, NSEC, IFORCE, ITP, NCO, NDN, NDE, NNE, NEQ);

    % ^^* UP TO HERE  --- PROG 3 ^^*

    % DELTA(Array)：delta => K * delta = P
    DELTA = SOLVE(GLK, GLOAD);

    % Determine the member end forces ELFOR(NDE,NBC)
    % ELFOR(Matrix)：內力
    ELFOR = FORCE(COOR, IDBC, VECTY, PROP, SECT, LM, FEF, GLOAD, NNOD, NBC, NMAT...
        , NSEC, IFORCE, ITP, NCO, NDN, NDE, NNE, NEQ, DELTA);

    axforce = ELFOR(4, 7);

    fprintf('Axial Force of Member 7 is %f when the concentrated load is applied at point %i \n', axforce, PT)

end

end