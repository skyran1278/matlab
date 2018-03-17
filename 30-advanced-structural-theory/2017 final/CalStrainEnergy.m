function [] = CalStrainEnergy(COOR, FORMAT, IDBC, LM, NEQ, NSEC, ...
    DELTA, FTYPE, IDND, LUNIT, NFIX, PROP, ...
    ELFOR, FUNIT, IFORCE, NBC, NMAT, SECT, ...
    EXLD, GLK, IPR, NCO, NNE, TITLE, ...
    FEF, GLOAD, IREAD, NDE, NNOD, VECTY, ...
    FILENAME, ID, ITP, NDN, NSBAND)
%CalStrainEnergy - Description
%
% Syntax: [] = CalStrainEnergy(COOR, FORMAT, IDBC, LM, NEQ, NSEC, ...
    % DELTA, FTYPE, IDND, LUNIT, NFIX, PROP, ...
    % ELFOR, FUNIT, IFORCE, NBC, NMAT, SECT, ...
    % EXLD, GLK, IPR, NCO, NNE, TITLE, ...
    % FEF, GLOAD, IREAD, NDE, NNOD, VECTY, ...
    % FILENAME, ID, ITP, NDN, NSBAND)
%
% Long description

fprintf('*Strain Energy \n');

for IB = 1 : NBC

    % T(Matrix)：transformation matrix
    % RL(Double)：桿件長度
    [T, RL] = ROTATION(COOR, VECTY, IDBC, IB, ITP, NCO, NDE);

    % Calculate the element stiffness matrix, EE
    % EE(Matrix)：得到該 ITP 的勁度矩陣
    EE = ELKE(ITP, NDE, IDBC, PROP, SECT, IB, RL);

    % Get element DOF
    % LDOF(Array)：找到 > 0 的位置
    LDOF = find(LM(:, IB) > 0);
    % GDOF(Array)：取出該自由度
    GDOF = LM(LDOF, IB);

    % Get element disp.
    % GDISP(Array)：由 eqution 變位到桿件自由度的變位
    GDISP = zeros(NDE, 1);
    GDISP(LDOF) = DELTA(GDOF);

    % Transform into local coordindate
    % LDISP(Array)：由全域變位到區域變位
    LDISP = T * GDISP;

    SE = LDISP.' * EE * LDISP / 2;

    fprintf('Member %i : %f\n', IB, SE);

end

end