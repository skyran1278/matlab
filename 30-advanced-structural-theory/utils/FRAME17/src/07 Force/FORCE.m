function ELFOR = FORCE(COOR, IDBC, VECTY, PROP, SECT, LM, FEF, GLOAD, NNOD, NBC, NMAT...
    , NSEC, IFORCE, ITP, NCO, NDN, NDE, NNE, NEQ, DELTA)
%..........................................................................
%   PURPOSE:  Find the member forces with respect to the local axes.
%
%   VARIABLES:
%     INPUT:
%        ...
%        ...
%        ...
%
%     OUTPUT:
%        ELFOR   = the member forces in local axes
%
%     INTERMEDIATE:
%        ...
%        ...
%        ...
%
%..........................................................................
ELFOR = zeros(NDE, NBC);

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

    %     Compute the member forces
    %     {ELFOR}=[EE]{LDISP}       (if IFORCE .EQ. 1)
    %     {ELFOR}=[EE]{LDISP}+{FEF} (if IFORCE .EQ. 2)
    % ELFOR(Matrix)�G���O
    if IFORCE == 1
        ELFOR(:, IB) = EE * LDISP;
    else
        ELFOR(:, IB) = EE * LDISP + FEF(:, IB);
    end

end
end