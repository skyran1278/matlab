function NSBAND = SEMIBAND(LM)
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

LM(LM < 0) = NaN;
NSBAND = max(max(LM) - min(LM) + 1);

end
