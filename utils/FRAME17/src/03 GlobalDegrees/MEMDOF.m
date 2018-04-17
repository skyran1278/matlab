function LM = MEMDOF(NDE, NBC, IDBC, IDND)
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
LM = zeros(NDE, NBC);

for IB = 1 : NBC
    LM(:, IB) = [IDND(:, IDBC(1, IB)); IDND(:, IDBC(2, IB))];
end

end
