function [T, RL] = ROTATION(COOR, VECTY, IDBC, IB, ITP, NCO, NDE)
%..........................................................................
%
%   PURPOSE: Compute the rotation matrix and the length of each element.
%
%   INPUT VARIABLES:
%     COOR(NCO,NNOD) = nodal coordinates
%     VECTY(3,NBC)   = direction of the y-axis for each member (ITP=6 only)
%     IDBC(5,NBC)    = Beam column ID number
%     IB             = member number
%     ITP            = frame type
%     NCO            = number of coordinates per node
%     NDE            = number of dofs per element
%
%   OUTPUT VARIABLES:
%     T(NDE,NDE)     = transformation matrix
%     RL             = the length of an element
%
%   INTERMEDIATE VARIABLES:
%     CO(2,NCO)      = nodal coordinates array
%     VECTYL         = the length of an VECTY
%     ROT            = rotation matrix
%..........................................................................

% Assign nodal coordinates to the CO array
CO = COOR(:, IDBC(1 : 2, IB))';

% Compute the element length RL
RL = sqrt(sum((CO(2, :) - CO(1, :)) .^ 2));

x = CO(2, 1) - CO(1, 1);

if ITP ~= 1
    y = CO(2, 2) - CO(1, 2);
end

switch(ITP)
    case 1 % Beam (lies in the x-y plane)
        % [R] = / 1 0 \
        %       \ 0 1 /
        ROT = eye(2);

    case 2 % Plane Truss (lies in the x-y plane)
        % [R] =   /  COS  SIN \
        %         \ -SIN  COS /
        ROT = [
            x, y;
            -y, x
            ] / RL;

    case 3 % Plane Frame (lies in the x-y plane)
        % [R] =   /  COS  SIN  0  \
        %         | -SIN  COS  0  |
        %         \   0    0   1  /
        ROT = [
            x, y, 0;
            -y, x, 0;
            0, 0, RL
            ] / RL;

    case 4 % Plane Grid(lies in the x-z plane)
         % [R] =   /  1    0    0   \
         %         |  0   COS -SIN  |
         %         \  0   SIN  COS  /
        ROT = [
            RL, 0, 0;
            0, x, y;
            0, -y, x
            ] / RL;

    case 5 % Space Truss
        % [R] =   /  x' \
        %         |  y' | => can be any vector
        %         \  z' / => can be any vector
        ROT = [
            x, y, CO(2, 3) - CO(1, 3);
            0, RL, 0;
            0, 0, RL
            ] / RL;

    case 6 % Space Frame
        % [R] =   /  x' \
        %         |  y' | => unit vector of one of the principal axes
        %         \  z' / => z' = x' * y'
        VECTYL = sqrt(sum(VECTY(:, IB) .^ 2));
        XVector = [x, y, CO(2, 3) - CO(1, 3)] / RL;
        YVector = VECTY(:, IB) / VECTYL;
        ZVector = cross(XVector, YVector);
        ROT = [XVector; YVector'; ZVector];

end

T = zeros(NDE);

if ITP <= 2
    M = 2;
else
    M = 3;
end

for index = 1 : NDE / M
    dof = (1 : M) + (index - 1) * M;
    T(dof, dof) = ROT;
end

end
