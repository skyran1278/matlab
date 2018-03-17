%     Advanced Structural Theory
%
%     Program Assignment No. 2 (weight=2)
%            (11/2/2017)
%        Due: 11/16/2017
%
%      (1) Complete functions IDMAT, MEMDOF, and SEMIBAND. 
%      (2) *Complete main program FRAME17 up to
%          % ^^* UP TO HERE  --- PROG 2 ^^*  
%      (3) Test your program : 
%          It is required that you test the above functions
%          using the two examples described in programming2.pdf
%          You should check IDND, NEQ, LM, and NSBAND.
%          Compare the results with those obtained by hand calculations.
%          (You should upload the results to the Ceiba. )
%
%
function [IDND,NEQ] = IDMAT(NFIX,NNOD,NDN)
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
%     NEQ              = number of equations
%
%   INTERMEDIATE VARIABLES:
%     N                = fixed d.o.f. numbering
%..........................................................................
IDND = zeros(NDN,NNOD);

% ...
% ...
% ...

end

function LM = MEMDOF(...)
%..........................................................................
%
%   PURPOSE: Calculate the location matrix LM for each element
%
%   INPUT VARIABLES:
%   ...
%   ...
%
%   OUTPUT VARIABLES:
%   ...
%..........................................................................
LM = zeros(NDE,NBC);
for j = 1:NBC
% ...
% ...
% ...
end
end

function NSBAND = SEMIBAND(...)
%..........................................................................
%   PURPOSE: Determine the semiband width of the global stiffness
%            matrix
%
%   INPUT VARIABLES:
%   ...
%   ...
%
%   OUTPUT VARIABLES:
%     NSBAND     = semiband width
%..........................................................................

%   ...
%   ...
%   ...

end

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
GLOAD = zeros(NEQ,1);
for j = 1:NNOD
    for i = 1:NDN
        if IDND(i,j) > 0
            GLOAD(IDND(i,j)) = GLOAD(IDND(i,j))+EXLD(i,j);
        end
    end
end
end