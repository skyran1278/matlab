function [IDND, NEQ] = IDMAT(NFIX, NNOD, NDN)
%..........................................................................
%
%   PURPOSE: Transform the NFIX matrix to equation (DOF) number matrix
%            IDND (nodal DOF table) and calculate the number of equation
%            (DOF), NEQ.
%
%
%   INPUT VARIABLES:
%     NFIX(NDN,NNOD)   = matrix specifying the boundary conditions
%     NNOD             = number of nodes
%     NDN              = number of DOFs per node
%
%   OUTPUT VARIABLES:
%     IDND(NDN,NNOD)   = matrix specifying the global DOF from nodal DOF
%     NEQ              = number of equations 總共幾條方程式
%
%   INTERMEDIATE VARIABLES:
%     N                = fixed d.o.f. numbering
%..........................................................................
IDND = zeros(NDN, NNOD);

positive = 0;
negative = 0;

for col = 1 : NNOD
    for row = 1 : NDN
        if NFIX(row, col) == 0
            positive = positive + 1;
            IDND(row, col) = positive;
        elseif NFIX(row, col) < 0
            negative = negative - 1;
            IDND(row, col) = negative;
        else
            IDND(row, col) = IDND(row, NFIX(row, col));
        end
    end
end

NEQ = positive;

end
