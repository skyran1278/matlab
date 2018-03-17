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

    %     Compute the member forces
    %     {ELFOR}=[EE]{LDISP}       (if IFORCE .EQ. 1)
    %     {ELFOR}=[EE]{LDISP}+{FEF} (if IFORCE .EQ. 2)
    % ELFOR(Matrix)：內力
    if IFORCE == 1
        ELFOR(:, IB) = EE * LDISP;
    else
        ELFOR(:, IB) = EE * LDISP + FEF(:, IB);
    end

end
end