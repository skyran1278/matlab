function [] = CalVolumeMassCost(IWRITE, NBC, COOR, VECTY, IDBC, ITP, NCO, NDE, SECT, PROP)
%CalVolumeMassCost - Description
%
% Syntax: [] = CalVolumeMassCost(IWRITE, NBC, COOR, VECTY, IDBC, ITP, NCO, NDE, SECT, PROP)
%
% Long description


V = 0;
M = 0;
C = 0;

for IB = 1 : NBC

    [~, RL] = ROTATION(COOR, VECTY, IDBC, IB, ITP, NCO, NDE);

    A = SECT(1, IDBC(4, IB));
    COST = PROP(3, IDBC(3, IB));
    RHO = PROP(4, IDBC(3, IB));

    V = V + A * RL;
    M = M + RHO * A * RL;
    C = C + COST * RHO * A * RL;

end

fprintf(IWRITE, 'Total Volume :%f m^3\r\n', V);
fprintf(IWRITE, 'Total Mass :%f kg\r\n', M);
fprintf(IWRITE, 'Total Cost :%f NTD\r\n', C);

end