function EE = ELKE(ITP, NDE, IDBC, PROP, SECT, IB, RL)
%..........................................................................
%
%   PURPOSE: Calculate the elastic element stiffness matrices EE
%            for all types of frame elements,
%            with reference to p.73 of McGuire et al. (2000).
%
%   INPUT VARIABLES:
%	  ...
%     ...
%     ...
%
%   OUTPUT VARIABLES:
%     EE(NDE,NDE)  = elastic element stiffness matrix
%
%   INTERMEDIATE VARIABLES:
%	  ...
%     ...
%     ...
%
%     Note that:
%       (1) There are some (redundant) sectional and/or material
%           properties that may not be needed when calculating
%           of some element stiffness coefficients. This is because
%           that our final purpose is to develop a 3D analysis
%           program for frame. You can change this part in the
%           future.
%       (2) In order to let the transformation matrix be a square
%           matrix, the dimensions of EE for planar and spatial
%           trusses are taken as 4x4 and 6X6, respectively, instead
%           of 2X2. This is not necessary and only for
%           convenience.
%..................................................................
E = PROP(1, IDBC(3, IB)); % Young's modulus
v = PROP(2, IDBC(3, IB)); % Poisson's ratio

A = SECT(1, IDBC(4, IB)); % cross-section area
Iz = SECT(2, IDBC(4, IB)); % moments of inertia Iz
Iy = SECT(3, IDBC(4, IB)); % moments of inertia Iy
J = SECT(4, IDBC(4, IB)); % torsional constant


%Stiffness matrix of a 3D beam-column element with bisymmetrical section
wholeEE = E * [A / RL, 0, 0, 0, 0, 0, - A / RL, 0, 0, 0, 0, 0;
          0, 12 * Iz / RL ^ 3, 0, 0, 0, 6 * Iz / RL ^ 2, 0, - 12 * Iz / RL ^ 3, 0, 0, 0, 6 * Iz / RL ^ 2;
          0 , 0, 12 * Iy / RL ^ 3, 0, - 6 * Iy / RL ^ 2, 0, 0, 0, - 12 * Iy / RL ^ 3, 0, - 6 * Iy / RL ^ 2, 0;
          0 , 0, 0, J ./ (2 * (1 + v) * RL), 0, 0, 0, 0, 0, - J ./ (2 * (1 + v) * RL), 0, 0;
          0, 0, - 6 * Iy / (RL ^ 2), 0, 4 * Iy / RL, 0, 0, 0, 6 * Iy / (RL ^ 2), 0, 2 * Iy / RL, 0;
          0 , 6 * Iz / (RL ^ 2), 0, 0, 0, 4 * Iz / RL, 0, - 6 * Iz / (RL ^ 2), 0, 0, 0, 2 * Iz / RL;
         - A / RL, 0, 0, 0, 0, 0, A / RL, 0, 0, 0, 0, 0;
          0, - 12 * Iz / (RL ^ 3), 0, 0, 0, - 6 * Iz / (RL ^ 2), 0, 12 * Iz / (RL ^ 3), 0, 0, 0, - 6 * Iz / (RL ^ 2);
          0, 0, - 12 * Iy / (RL ^ 3), 0, 6 * Iy / (RL ^ 2), 0, 0, 0, 12 * Iy / (RL ^ 3), 0, 6 * Iy / (RL ^ 2), 0;
          0, 0, 0, - J / (2 * (1 + v) * RL), 0, 0, 0, 0, 0, J / (2 * (1 + v) * RL), 0, 0;
          0, 0, - 6 * Iy / (RL ^ 2), 0, 2 * Iy / (RL), 0, 0, 0, 6 * Iy / (RL ^ 2), 0, 4 * Iy / (RL), 0;
          0, 6 * Iz / (RL ^ 2), 0, 0, 0, 2 * Iz / (RL), 0, - 6 * Iz / (RL ^ 2), 0, 0, 0, 4 * Iz / (RL)];


switch(ITP)
    case 1 % Beam (lies in the x-y plane)
        EE = wholeEE([2 6 8 12], [2 6 8 12]);

    case 2 % Plane Truss (lies in the x-y plane)
        EE = wholeEE([1 2 7 8], [1 2 7 8]);

    case 3 % Plane Frame (lies in the x-y plane)
        EE = wholeEE([1 2 6 7 8 12], [1 2 6 7 8 12]);

    case 4 % Plane Grid(lies in the x-z plane)
        EE = wholeEE([2 4 6 8 10 12], [2 4 6 8 10 12]);

    case 5 % Space Truss
        EE = wholeEE([1 2 3 7 8 9], [1 2 3 7 8 9]);

    case 6 % Space Frame
        EE = wholeEE;

    otherwise
        error('ITP out of range.')
end


end
