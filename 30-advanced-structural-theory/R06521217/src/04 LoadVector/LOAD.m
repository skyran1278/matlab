function GLOAD = LOAD(EXLD,IDND,NDN,NNOD,NEQ)
%..........................................................................
%
%   PURPOSE: Forms the global load vector using the input loads EXLD
%
%   INPUT VARIABLES:
%     EXLD(NDN,NNOD) = input load matrix
%     IDND(NDN,NNOD) = matrix specifying the global DOF form nodal DOF
%     NDN            = number of DOFs per node
%     NNOD           = number of nodes
%     NEQ            = number of equations
%
%   INTERMEDIATE VARIABLES:
%     GLOAD(NEQ)     = global load vector
%..........................................................................
GLOAD = zeros(NEQ, 1);
for j = 1: NNOD
    for i = 1: NDN
        if IDND(i, j) > 0
            GLOAD(IDND(i, j)) = GLOAD(IDND(i, j)) + EXLD(i, j);
        end
    end
end

end
