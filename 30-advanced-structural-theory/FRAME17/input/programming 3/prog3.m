%
%     Advanced Structural Theory
%
%     Program Assignment No. 3 (weight=3)
%            (11/23/2017)
%       Due: 12/7/2017
%
%       1. Complete the main program FRAME17 up to
%          % ^^* UP TO HERE  --- PROG 3 ^^*
%       2. Complete the following functions:
%          (a) FORMKP
%          (b) ROTATION (for ITP=3,4&6)
%          (c) ELKE
%       3. Use the following examples to verify stiffness matrices [Kff]:
%          (a) Consider a beam with an internal hinge at point b.
%              There are three nodes a,b,and c; their coordinates are
%              x=0,2L,and 3L, respectively, where L=3m. Young's modulus 
%              E=120 GPa and I=0.00008 m^4. The beam is fixed at nodes a and c, 
%              and is subjected to a downward load P=250 kN. (ITP=1)
%          (b)Example 3.2 on page 36 of textbook (ITP=2)
%          (c)Example 5.7 on page 115 of textbook (ITP=3)
%          (d)The grid structure example discussed in class (ITP=4)
%          (e)Example 5.4  on page 104 of textbook (ITP=5)
%            *** You shall assemble the element stiffness matrices
%                first in order to check the solution from your program.
%          (f)Problem 5.10(c)(ITP=6) (on page 134 of textbook) but
%             with the following changes: 
%              (1) delete member cd (only two members ab and bc)
%              (2) Lengths: ab=4m, bc=6m  
%              (3) member ab: A=38000 mm^2, Iy=1400X10^6 mm^4 and Iz=380X10^6 mm^4
%                              J=1600X10^6 mm^4
%              (4) member bc: A=25000 mm^2, Iy=800X10^6 mm^4 and Iz=700X10^6 mm^4
%                              J=2600X10^6 mm^4
%              (5) Note that the local y-axis of member ab is along "-Z" direction
%                  and that of member bc is along the "X" direction. 
%              (6) E=200 GPa and v=0.3
%              (7) Assume there is no distributed load and a vertical force applied
%                  at point C; its value=80 kN and the direction is downward. 
%
function [GLK,GLOAD] = FORMKP(COOR,IDBC,VECTY,PROP,SECT,LM,FEF,GLOAD,NNOD,NBC,NMAT...
    ,NSEC,IFORCE,ITP,NCO,NDN,NDE,NNE,NEQ)
%..........................................................................
%
%   PURPOSE: Form the global stiffness matrix GLK.
%
%   INPUT VARIABLES:
%     ...
%     ...
%     ...
%   OUTPUT VARIABLES:
%     GLK(NEQ,NSBAND)= the global stiffness matrix in banded form
%     ...
%
%   INTERMEDIATE VARIABLES:
%     ...
%..........................................................................

%--------------------------------------------------------------------------
%     FORM [K]
%--------------------------------------------------------------------------
% Preallocate the global stiffness matrix
%GLK = spalloc(NEQ,NEQ,NEQ*NEQ);
GLK = zeros(NEQ);

for IB = 1:NBC
    % Calculate the element rotation matrix ROT and the length RL
    [T,RL] = ROTATION(COOR,VECTY,IDBC,IB,ITP,NCO,NDE);
    
    % Calculate the element stiffness matrix, EE
    EE = ELKE( ... );
    
    % Get element DOF
    
    % ...
    % ...
    % ...
    
    % Transform the element stiffness matrix from the local axes to global
    % axes : EE --> ELK
    
    % ...
    
    % Assemble the global element stiffness matrix to form the global
    % stiffness matrix GLK
    
    % ...
    
    % This part is to be completed in PROG4.
    % -----------------------------------------------------------------
    % FORM {P} (add the part arising from equivalent member end forces)
    % -----------------------------------------------------------------
    % ****** ADDFEF will be added in PROG4 *****
    if IFORCE == 2
        % ...
    end
end
end

function [T,RL] = ROTATION(COOR,VECTY,IDBC,MN,ITP,NCO,NDE)
%..........................................................................
%
%   PURPOSE: Compute the rotation matrix and the length of each element.
%
%   INPUT VARIABLES:
%     COOR(NCO,NNOD) = nodal coordinates
%     VECTY(3,NBC)   = direction of the y-axis for each member (ITP=6 only)
%     IDBC(5,NBC)    = Beam column ID number
%     MN             = member number
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
CO = COOR(1:NCO,IDBC(1:2,MN))';
% Compute the element length RL
RL = sqrt(sum((CO(2,:)-CO(1,:)).^2));
switch(ITP)
    case 1 % Beam
        % [R] = / 1 0 \
        %       \ 0 1 /
        ROT = eye(2);
    case 2 % Plane Truss
        % [R] =   /  COS  SIN \
        %         \ -SIN  COS /
        ROT = [CO(2,1)-CO(1,1),CO(2,2)-CO(1,2);
            -CO(2,2)-CO(1,2),CO(2,1)-CO(1,1)]/RL;
        
    % ...
    % ...
    % ...
    
    case 5 % Space Truss
        ROT = [CO(2,1)-CO(1,1),CO(2,2)-CO(1,2),CO(2,3)-CO(1,3);
            0,RL,0;
            0,0,RL]/RL;
        
    % ...
    % ...
    % ...
    
end

T = zeros(NDE);
if ITP <= 2
    M = 2;
else
    M = 3;
end
for i = 1:NDE/M
    dof = (1:M)+(i-1)*M;
    T(dof,dof) = ROT;
end
end

function EE = ELKE(ITP,NDE,IDBC,PROP,SECT,IB,RL)
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
switch(ITP)
    
    % ...
    % ...
    % ...
    
    otherwise
        error('ITP out of range.')
end
end