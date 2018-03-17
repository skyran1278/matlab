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

    % T(Matrix)�Gtransformation matrix
    % RL(Double)�G������
    [T, RL] = ROTATION(COOR, VECTY, IDBC, IB, ITP, NCO, NDE);

    % Calculate the element stiffness matrix, EE
    % EE(Matrix)�G�o��� ITP ���l�ׯx�}
    EE = ELKE(ITP, NDE, IDBC, PROP, SECT, IB, RL);

    % Get element DOF
    % LDOF(Array)�G��� > 0 ����m
    LDOF = find(LM(:, IB) > 0);
    % GDOF(Array)�G���X�Ӧۥѫ�
    GDOF = LM(LDOF, IB);

    % Get element disp.
    % GDISP(Array)�G�� eqution �ܦ����ۥѫת��ܦ�
    GDISP = zeros(NDE, 1);
    GDISP(LDOF) = DELTA(GDOF);

    % Transform into local coordindate
    % LDISP(Array)�G�ѥ����ܦ��ϰ��ܦ�
    LDISP = T * GDISP;

    SE = LDISP.' * EE * LDISP / 2;

    fprintf('Member %i : %f\n', IB, SE);

end

end