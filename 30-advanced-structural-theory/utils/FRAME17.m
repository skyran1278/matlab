%     Advanced Structural Theory
%
%     Program Assignment No. 1 (weight=1)
%
%     Note that each program assignment has its own weight.
%     Usually, the larger the weight, the more time you are expected
%     to spend on the assignment.
%
%        Assigned: (10/19/2017)
%        Due: (11/2/2017)
%
%      (1) Complete function INPUT
%      (2) Complete the main program FRAME17 up to
%          % ^^* UP TO HERE  --- PROG 1 ^^*
%      (3) Test problem: see programming 1.pdf; you shall
%		   create an input file and run the program to write out
%          the data (in subroutine INPUT) to see if the output
%          data are the same as the input data. In addition, use function
%          drawingStructure to check the geometry of the structures.
%      (4) Sumbit the following to CEIBA in archive file (*.zip or *.rar):
%          (a) Program source code "FRAME17.m"
%          (b) Input file "*.ipt"
%
%
function FRAME17(FILENAME)

% FRAME17: A linear analysis program for framed structures
%..........................................................................
%    Programmer:  張竣翔 謝佳霖
%                 Supervised by Professor Liang-Jenq Leu
%                 For the course: Advanced Structural Theory
%                 Department of Civil Engineering
%                 National Taiwan University
%                 Fall 2017 @All Rights Reserved
%..........................................................................

%    VARIABLES:
%        NNOD   = number of nodes
%        NBC    = number of Beam-column elements
%        NCO    = number of coordinates per node
%        NDN    = number of DOFs per node
%        NNE    = number of nodes per element
%        NDE    = number of DOFs per element
%        NMAT   = number of material types
%        NSEC   = number of cross-sectional types
%        IFORCE = 1 if only concentrated loads are applied
%               = 2 if fixed-end forces are required.
%                   (e.g. problems with distributed loads, fabrication
%                   errors, temperature change, or support settlement)
%    CHARACTERS
%        FUNIT  = unit of force (such as kN and kip)
%        LUNIT  = unit of length (such as mm and in)
%..........................................................................

%    FRAME TYPE    ITP  NCO  NDN   (NCO and NDN are stored in Array IPR)
%           BEAM    1    1    2
%   PLANAR  TRUSS   2    2    2
%   PLANAR  FRAME   3    2    3
%   PLANAR  GRID    4    2    3
%   SPACE   TRUSS   5    3    3
%   SPACE   FRAME   6    3    6

FTYPE = {'BEAM';'PLANE TRUSS';'PLANE FRAME';'PLANE GRID';...
    'SPACE TRUSS';'SPACE FRAME'};
IPR = [1,2,2,2,3,3 ;  2,2,3,3,3,6];

if nargin == 0 % no input argument
    % Open file with user interface
    [~,FILENAME] = fileparts(uigetfile('*.ipt','Select Input file'));
end

% Get starting time
startTime = clock;

% FILENAME.ipt is the input data file.
% FILENAME.dat includes the output of the input data and
%   the nodal displacements and member end forces.

IREAD = fopen([FILENAME '.ipt'], 'r');

% Read in the problem title and the structural data
TITLE = fgets(IREAD);
FUNIT = fgets(IREAD);
LUNIT = fgets(IREAD);
ID = '*';
HEADLINE(ID,IREAD);
line = fgets(IREAD);
args = str2num(line);
[NNOD,NBC,NMAT,NSEC,ITP,NNE,IFORCE] = deal(args(1),args(2),args(3),args(4),args(5),args(6),args(7));
NCO = IPR(1,ITP);
NDN = IPR(2,ITP);
NDE = NDN*NNE;

% Read the remaining data
disp(TITLE);
disp(FUNIT);
disp(LUNIT);
disp('* NNOD  NBC  NMAT  NSEC  ITP  NNE  IFORCE');
disp(line);
FORMAT='black';
[COOR ,NFIX,EXLD,IDBC,PROP,SECT,VECTY,FEF] = INPUT(IREAD,ID,NNOD,NCO,NBC,NDN,NDE,NMAT,NSEC,ITP,IFORCE);

drawingStructure(ITP,COOR,IDBC,NBC,LUNIT,FORMAT);


% Read the remaining data
% [COOR,~] = INPUT(IREAD,ID,NNOD,NCO,~);
fclose(IREAD);

% ^^* UP TO HERE  --- PROG 1 ^^*

%
% % DOF numbering
[IDND,NEQ] = IDMAT(NFIX,NNOD,NDN);
display(IDND);
%
% % Compute the member DOF table:  LM(NDE,NBC)
LM = MEMDOF(IDBC,IDND,NDE,NBC,NDN);
display(LM);
%
% % Compute the semi-band width,NSBAND, of the global stiffness matrix
NSBAND = SEMIBAND(LM,NBC);
display(NSBAND);

%
% %Form the global load vector GLOAD(NEQ) from the concentrated nodal loads
GLOAD = LOAD(EXLD,IDND,NDN,NNOD,NEQ);

%
% % ^^* UP TO HERE  --- PROG 2 ^^*
%
% % Form the global stiffness matrix GLK(NEQ,NSBAND) and obtain the
% % equivalent nodal vector by assembling -(fixed-end forces) of each member
% % into the load vector.
[GLK,GLOAD] = FORMKP(COOR,IDBC,VECTY,PROP,SECT,LM,GLOAD,NNOD,NBC,NMAT...
    ,NSEC,IFORCE,ITP,NCO,NDN,NDE,NNE,NEQ,FEF);
display(GLK);
%
% % ^^* UP TO HERE  --- PROG 3 ^^*
%
DELTA = SOLVE(GLK,GLOAD);

%
% % Determine the member end forces ELFOR(NDE,NBC)

ELFOR = FORCE(NDE,NBC,COOR,VECTY,IDBC,ITP,NCO,PROP,SECT,IDND,NDN,GLK,GLOAD,FEF,LM,DELTA,IFORCE);
%
% % Get ending time and count the elapased time
 endTime = clock;
%
% % Print out the results
IWRITE = fopen([FILENAME '.dat'], 'w');
OUTPUT(IWRITE,TITLE,FILENAME,FTYPE,FUNIT,LUNIT,startTime,endTime,...
    NNOD,NBC,NMAT,NSEC,NEQ,NCO,NDN,NNE,ITP,COOR,NFIX,PROP,SECT,IDBC,IDND,...
    VECTY,EXLD,IFORCE,FEF,DELTA,ELFOR,NSBAND);

fclose(IWRITE);
%
IGW = fopen([FILENAME '.txt'], 'w');
GRAPHOUTPUT(IGW,COOR,NFIX,EXLD,IDBC,FEF,PROP,SECT,LM,IDND,DELTA,ELFOR,NNOD,...
    NDN,NCO,NDE,NEQ,NBC,NMAT,NSEC,ITP,NNE,IFORCE,FUNIT,LUNIT);
 fclose(IGW);
%
% % ^^* UP TO HERE  --- PROG 4 ^^*

end

function HEADLINE(ID,IREAD)
while ~feof(IREAD)
    temp = fgets(IREAD);
    if ~isempty(temp) && temp(1) == ID
        return
    end
end
end

function [COOR ,NFIX,EXLD,IDBC,PROP,SECT,VECTY,FEF...
   ] = INPUT(IREAD,ID,NNOD,NCO,NBC,NDN,NDE,NMAT,NSEC,ITP,IFORCE)
%..........................................................................
%
%    PURPOSE: Reads in the following data: nodal coordinates,
%             boundary conditions, external nodal loads, identification
%             data (connectivity), direction cosines of the local y-axis
%             (for space frame only; ITP=6), fixed-end forces, material
%             and cross sectional properties.
%
%    VARIABLES:
%      IREAD          = index of input stream
%      ID             = identifier charactor of input file
%      NNOD           = number of nodes
%      NBC            = number of Beam-column elements
%      NMAT           = number of material types
%      NSEC           = number of cross-sectional types
%      ITP            = frame tyoe
%      NCO            = number of coordinates per node
%      NDN            = number of DOFs per node
%      NDE            = number of DOFs per element
%      IFORCE         = indicator for fixed-end forces (FEF)
%                     = 1 for the case of ONLY concentrated nodal loads;
%                       no need to input FEF.
%                     = 2 for the following cases: distributed loads,
%                       temperature change, support settlement;
%                       need to input FEF for each member.
%      COOR(NCO,NNOD) = nodal coordinates
%      NFIX(NDN,NNOD) = Boolian id matrix for specifying boundary conditions
%                     = -1 for restrained d.o.f.
%                     =  0 for free d.o.f.
%                     = the first node number for the d.o.f.
%                       that has the same d.o.f. of the second node
%                       when "the double node technique" is used.
%
%      EXLD(NDN,NNOD) = external nodal loads
%      IDBC(5,NBC)    = Beam-column identification data
%                       (1,*) = local node 1
%                       (2,*) = local node 2
%                       (3,*) = material type.
%                       (4,*) = section type.
%                       (5,*) = omitted.
%      VECTY(3,NBC)   = direction cosines of the local y-axis
%                       VECTY is needed only when ITP=6 (space frame)
%      FEF(NDE,NBC)   = FEF is needed only when IFORCE=2
%      PROP(5,NMAT)   = material properties
%                       (1,*) = Young's modulus
%                       (2,*) = Poision ratio.
%                       (3,*) = omitted.
%                       (4,*) = omitted.
%                       (5,*) = omitted.
%      SECT(5,NSEC)   = Beam-column properties
%                       (1,*) = cross-sectional area A.
%                       (2,*) = moment of inertia Iz (3D)
%                       (3,*) = moment of inertia Iy (3D)
%                       Note that for 2D problems, only Iz is required.
%                       (4,*) = torsional constant J.
%                       (5,*) = omitted.
%..........................................................................

% COOR - Nodal coordinates
HEADLINE(ID,IREAD);
COOR = ReadMatrix(IREAD,NCO,NNOD);
disp('* COOR (mm)');
disp(COOR');
HEADLINE(ID,IREAD);
NFIX = ReadMatrix(IREAD,NDN,NNOD);
disp('* NFIX');
disp(NFIX');
HEADLINE(ID,IREAD);
EXLD = ReadMatrix(IREAD,NDN,NNOD);
disp('* EXLD (kN)');
disp(EXLD');
HEADLINE(ID,IREAD);
IDBC = ReadMatrix(IREAD,5,NBC);
disp('* IDBC');
disp(IDBC');
HEADLINE(ID,IREAD);
PROP = ReadMatrix(IREAD,5,NMAT);
disp('* PROP');
for i = 1:NMAT
    for j = 1:5
        fprintf('%10.2f\t',PROP(j,i));
    end
        fprintf('\n');
end
fprintf('\n');
HEADLINE(ID,IREAD);
SECT = ReadMatrix(IREAD,5,NSEC);
disp('* SECT');
disp(SECT');

if ITP ==6
    disp('* VECTY');
    HEADLINE(ID,IREAD);
    VECTY = ReadMatrix(IREAD,3,NBC);
    disp(VECTY');
else
    VECTY = zeros(3,NBC);
end

if IFORCE == 2
    disp('* FEF');
    HEADLINE(ID,IREAD);
    FEF = ReadMatrix(IREAD,NDE,NBC);
    disp(FEF');
else
    FEF = zeros(NDE,NBC);
end

end

function mat = ReadMatrix(IREAD, row, col)
% for function INPUT
mat = zeros(row,col);
for j = 1:col
    line = fgets(IREAD);
    num = str2num(line);
    mat(:,j) = num(2:row+1);
end
end

function drawingStructure(ITP,COOR,IDBC,NBC,LUNIT,FORMAT)
switch ITP
    case 1
        for e=1:NBC
            plot([COOR(IDBC(1,e)),COOR(IDBC(2,e))],[0,0],FORMAT,'linewidth',2)
            xlabel(['X ', LUNIT])
            title('Beam')
            hold on
        end
        hold off
    case {2,3}
        for e=1:NBC
            plot([COOR(1,IDBC(1,e)),COOR(1,IDBC(2,e))],...
                [COOR(2,IDBC(1,e)),COOR(2,IDBC(2,e))],FORMAT,'linewidth',2)
            % 分別是 node1x node2x node1y node2y
            xlabel(['X ', LUNIT])
            ylabel(['Y ', LUNIT])
            if ITP==2
                title('2D truss')
            else
                title('2D frame')
            end
            hold on
        end
        axis equal
        hold off
    case 4
        for e=1:NBC
            plot([COOR(1,IDBC(1,e)),COOR(1,IDBC(2,e))],...
                [COOR(2,IDBC(1,e)),COOR(2,IDBC(2,e))],FORMAT,'linewidth',2)
            xlabel(['X ', LUNIT])
            ylabel(['Z ', LUNIT])
            title('grid')
            hold on
        end
        axis equal
        hold off
    case {5,6}
        for e=1:NBC
            plot3([COOR(1,IDBC(1,e)),COOR(1,IDBC(2,e))],...
                [COOR(2,IDBC(1,e)),COOR(2,IDBC(2,e))],...
                [COOR(3,IDBC(1,e)),COOR(3,IDBC(2,e))],FORMAT,'linewidth',2)
            xlabel(['X ', LUNIT])
            ylabel(['Y ', LUNIT])
            zlabel(['Z ', LUNIT])
            if ITP==5
                title('3D truss')
            else
                title('3D frame')
            end
            hold on
        end
        axis equal
        hold off
end
end
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
FIXDOF = 0;
FREEDOF = 0;
for i = 1:NNOD
    for j = 1:NDN
        if NFIX(j,i) == -1
            FIXDOF = FIXDOF - 1;
            IDND(j,i) = FIXDOF;
        elseif NFIX(j,i) == 0
            FREEDOF = FREEDOF +1;
            IDND(j,i) = FREEDOF;
        else
            IDND(j,i) = IDND(j,NFIX(j,i));
        end
    end
end
NEQ = FREEDOF;


end
function LM = MEMDOF(IDBC,IDND,NDE,NBC,NDN)
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


    %IDBC(1,j) first node of each element
    %IDBC(2,j) second node of each element
    %LM(1,j) = IDND(1,IDBC(1,j));
    %LM(2,j) = IDND(2,IDBC(1,j));
    %LM(3,j) = IDND(1,IDBC(2,j));
    %LM(4,j) = IDND(2,IDBC(2,j));
    LM(:,j) = [IDND(1:NDN,IDBC(1,j)); IDND(1:NDN,IDBC(2,j)) ];


    %LM(i,j) =
% ...
% ...
% ...
end
end

function NSBAND = SEMIBAND(LM,NBC)
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
semi = zeros(1,NBC);
for i = 1:NBC
    LMperELE = LM(:,i) ;
    if LMperELE < 0
        continue;
    else
    x =  LMperELE >0;
    max1 = max( LMperELE(x) );
    min1 = min( LMperELE(x) );
    semi(1,i) = max1-min1+1;
    end
end


NSBAND = max(semi);

%NSBAND =
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
function [GLK,GLOAD] = FORMKP(COOR,IDBC,VECTY,PROP,SECT,LM,GLOAD,NNOD,NBC,NMAT...
    ,NSEC,IFORCE,ITP,NCO,NDN,NDE,NNE,NEQ,FEF)
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
    EE = ELKE(ITP,IDBC,PROP,SECT,IB,RL);
    
    
    % Get element DOF
    LDOF = find(LM(:,IB)>0);
    GDOF = LM(LDOF,IB);
    
    
    % Transform the element stiffness matrix from the local axes to global
    % axes : EE --> ELK
    
    ELK = T' * EE * T;
    
    % Assemble the global element stiffness matrix to form the global
    % stiffness matrix GLK
    
    GLK(GDOF,GDOF) = GLK(GDOF,GDOF) + ELK(LDOF,LDOF);
    
    % This part is to be completed in PROG4.
    % -----------------------------------------------------------------
    % FORM {P} (add the part arising from equivalent member end forces)
    % -----------------------------------------------------------------
    % ****** ADDFEF will be added in PROG4 *****
    if IFORCE == 2
        EFEQ = -T' * FEF(:,IB);
        GLOAD(GDOF) = GLOAD(GDOF) + EFEQ(LDOF);
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
        ROT = [CO(2,1)-CO(1,1),    CO(2,2)-CO(1,2);
            -CO(2,2)+CO(1,2),        CO(2,1)-CO(1,1)]/RL;
    case 3% 2D Frame
        ROT = [CO(2,1)-CO(1,1)   CO(2,2)-CO(1,2)     0;
                 -CO(2,2)+CO(1,2)  CO(2,1)-CO(1,1)      0;
                           0                    0                 RL]/RL;
    case 4 % Grid
        ROT =[        RL                  0                   0;
                          0         CO(2,1)-CO(1,1)     CO(2,2)-CO(1,2);
                          0        -CO(2,2)+CO(1,2)     CO(2,1)-CO(1,1)]/RL;
    
    case 5 % Space Truss
        ROT = [CO(2,1)-CO(1,1),  CO(2,2)-CO(1,2),CO(2,3)-CO(1,3);
                            0,                    RL,                  0;
                            0,                     0,                  RL]/RL;
    case 6% 3D Frame
        Y_L = sqrt(VECTY(1,MN)^2+VECTY(2,MN)^2+VECTY(3,MN)^2);
        X = [CO(2,1)-CO(1,1),  CO(2,2)-CO(1,2),CO(2,3)-CO(1,3)]/RL;
        Y = [VECTY(1,MN),VECTY(2,MN),VECTY(3,MN)]/Y_L;
        Z = cross(X,Y);
        ROT = [X;Y;Z];
%         ROT =[CO(2,1)-CO(1,1),  CO(2,2)-CO(1,2),CO(2,3)-CO(1,3);
%                     RL*VECTY(1,MN),    RL*VECTY(2,MN),       RL*VECTY(3,MN)  ;                                              
%                           0                       0                   RL          ]/RL;    
    
    
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

function EE = ELKE(ITP,IDBC,PROP,SECT,IB,RL)
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
        
        E = PROP(1,IDBC(3,IB));
        v = PROP(2,IDBC(3,IB));
        A = SECT(1,IDBC(4,IB));
        I = SECT(2,IDBC(4,IB));  %I_z
        I_y = SECT(3,IDBC(4,IB));
        J = SECT(4,IDBC(4,IB));
        
switch(ITP)
    
    case 1 % Beam
        
        EE = [12*E*I/RL^3    6*E*I/RL^2   -12*E*I/RL^3       6*E*I/RL^2;
               6*E*I/RL^2       4*E*I/RL     -6*E*I/RL^2      2*E*I/RL;
             -12*E*I/RL^3     -6*E*I/RL^2    12*E*I/RL^3    -6*E*I/RL^2;                                                                
               6*E*I/RL^2       2*E*I/RL        -6*E*I/RL^2      4*E*I/RL];                                                                 
    case 2 % Plane Truss
        EE  = [E*A/RL   0   -E*A/RL  0;
                  0     0      0     0;
               -E*A/RL  0    E*A/RL  0;
                  0     0      0     0];
        
    case 3% 2D Frame
        EE = [E*A/RL       0                 0          -E*A/RL            0            0;
                 0        12*E*I/RL^3    6*E*I/RL^2        0         -12*E*I/RL^3   6*E*I/RL^2;
                 0        6*E*I/RL^2     4*E*I/RL          0           -6*E*I/RL^2   2*E*I/RL;
              -E*A/RL        0               0            E*A/RL            0           0;
                 0       -12*E*I/RL^3   -6*E*I/RL^2        0           12*E*I/RL^3   -6*E*I/RL^2;
                 0        6*E*I/RL^2     2*E*I/RL           0           -6*E*I/RL^2   4*E*I/RL];
                
                                                          
    case 4 % Grid
%         EE = [12*E*I/RL^3       0          6*E*I/RL^2    -12*E*I/RL^3     0           6*E*I/RL^2;                                                                          
%                     0       J/(2*RL*(1+v))       0             0      -J/(2*RL*(1+v))     0;                                                               
%                6*E*I/RL^2       0          4*E*I/RL      -6*E*I/RL^2      0           2*E*I/RL;                                                         
%              -12*E*I/RL^3       0         -6*E*I/RL^2    12*E*I/RL^3      0          -6*E*I/RL^2;                                                                   
%                     0      -J/(2*RL*(1+v))      0              0      J/(2*RL*(1+v))      0;                                          
%                6*E*I/RL^2       0          2*E*I/RL       -6*E*I/RL^2     0           4*E*I/RL  ];

            EE=E*[12*I/RL^3 0 6*I/RL^2 -12*I/RL^3 0 6*I/RL^2 ;
                     0  J/(2*(1+v)*RL) 0 0  -J/(2*(1+v)*RL) 0;
                     6*I/RL^2 0 4*I/RL -6*I/RL^2 0 2*I/RL ;
                    -12*I/RL^3 0 -6*I/RL^2 12*I/RL^3 0 -6*I/RL^2 ;
                    0  -J/(2*(1+v)*RL) 0 0  J/(2*(1+v)*RL) 0;
                    6*I/RL^2 0 2*I/RL -6*I/RL^2 0 4*I/RL] ;

    
    case 5 % Space Truss
       EE = [E*A/RL    0       0   -E*A/RL       0   0;
                0      0       0       0         0   0;
                0      0       0       0         0   0;
            -E*A/RL    0       0    E*A/RL       0   0;
                0      0       0       0         0   0;
                0      0       0       0         0   0 ];
       
    case 6% 3D Frame
%         EE = [E*A/RL     0         0           0         0          0      -E*A/RL     0         0           0       0           0;
%                  0    12*E*I/RL^3  0           0         0      6*E*I/RL^2    0   -12*E*I/RL^3   0           0       0       6*E*I/RL^2;
%                  0       0      12*E*I_y/RL^3  0    -6*E*I_y/RL^2   0         0        0     -12*E*I_y/RL^3  0  -6*E*I_y/RL^2    0;
%                  0       0         0     J/(2*RL*(1+v))  0          0         0        0         0     -J/(2*RL*(1+v))  0        0;
%                  0       0     -6*E*I_y/RL^2   0     4*E*I_y/RL     0         0        0      6*E*I_y/RL^2   0       2*E*I_y/RL  0;
%                  0    6*E*I/RL^2   0           0         0       4*E*I/RL     0    -6*E*I/RL^2   0           0       0        2*E*I/RL ;
%               -E*A/RL    0         0           0         0          0       E*A/RL     0         0           0       0           0;
%                  0   -12*E*I/RL^3  0           0         0     -6*E*I/RL^2    0    12*E*I/RL^3   0           0       0       -6*E*I/RL^2;   
%                  0       0     -12*E*I_y/RL^3  0     6*E*I_y/RL^2   0         0        0      12*E*I_y/RL^3  0   6*E*I_y/RL^2    0;
%                  0       0         0     -J/(2*RL*(1+v)) 0          0         0        0         0      J/(2*RL*(1+v))  0        0;
%                  0       0     -6*E*I_y/RL^2   0     2*E*I_y/RL     0         0        0      6*E*I_y/RL^2   0       4*E*I_y/RL  0;
%                  0   -6*E*I/RL^2   0           0         0       2*E*I/RL     0    -6*E*I/RL^2   0           0       0        4*E*I/RL ] ;
            EE=E*[A/RL 0 0 0 0 0    -A/RL 0 0 0 0 0;
                     0 12*I/RL^3 0 0 0 6*I/RL^2      0 -12*I/RL^3 0 0 0 6*I/RL^2 ;
                     0 0 12*I_y/RL^3 0 -6*I_y/RL^2 0     0 0 -12*I_y/RL^3 0 -6*I_y/RL^2 0;
                     0 0 0 J/(2*(1+v)*RL) 0 0   0 0 0 -J/(2*(1+v)*RL) 0 0;
                     0 0 -6*I_y/RL^2 0 4*I_y/RL 0        0 0 6*I_y/RL^2 0 2*I_y/RL 0;
                     0 6*I/RL^2 0 0 0 4*I/RL         0 -6*I/RL^2 0 0 0 2*I/RL;
                     -A/RL 0 0 0 0 0     A/RL 0 0 0 0 0;
                     0 -12*I/RL^3 0 0 0 -6*I/RL^2    0 12*I/RL^3 0 0 0 -6*I/RL^2 ;
                    0 0 -12*I_y/RL^3 0 6*I_y/RL^2 0     0 0 12*I_y/RL^3 0 6*I_y/RL^2 0;
                     0 0 0 -J/(2*(1+v)*RL) 0 0  0 0 0 J/(2*(1+v)*RL) 0 0;
                     0 0 -6*I_y/RL^2 0 2*I_y/RL 0        0 0 6*I_y/RL^2 0 4*I_y/RL 0;
                    0 6*I/RL^2 0 0 0 2*I/RL         0 -6*I/RL^2 0 0 0 4*I/RL];
    otherwise
        error('ITP out of range.')
end
end
function DELTA = SOLVE(GLK,GLOAD)
%..........................................................................
%   PURPOSE:   Solve the global stiffness equations for
%              nodal displacements using the banded global
%              stiffness matrix and place the results in
%              DELTA.
%
%   VARIABLES:
%     GLK(NEQ,NSBAND)= global stiffness matrix in banded form
%	  GLOAD(NEQ)     = nodal load vector
%
%   Note that to make things more clear, the displacement vector
%   is stored in array DELTA; you should know that this is in
%   general not necessary because often the displacement vector
%   is also stored in array GLOAD. In addition, this subroutine
%   assumes only a single right-hand side.  It can be modified
%   to handle multiple right-hand sides easily.
%..........................................................................

%     Check for structure instability by examining the diagonal
%     elements of [GLK].  If a zero value is found, print a warning
%     and exit the program.  (Note that as [GLK] is in banded form,
%     the diagonal elements all appear in the first column.)
for i = 1:length(GLK)
    if find(GLK(i,i)==0,1)
        error(['*** ERROR *** Diagonal element found with zero value. ' ...
            'Check structure for instability ' ...
            'Zero coefficient in row ' num2str(i) '.']);
    end
end

DELTA = GLK\GLOAD;
display(DELTA);
end

function ELFOR = FORCE(NDE,NBC,COOR,VECTY,IDBC,ITP,NCO,PROP,SECT,IDND,NDN,GLK,GLOAD,FEF,LM,DELTA,IFORCE)
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
ELFOR = zeros(NDE,NBC);
for IB = 1:NBC
    [T,RL] = ROTATION(COOR,VECTY,IDBC,IB,ITP,NCO,NDE);
    % Calculate the element stiffness matrix, EE
    EE = ELKE(ITP,IDBC,PROP,SECT,IB,RL);
    % Get element DOF
    LDOF=find(LM(:,IB)>0);
    GDOF=LM(LDOF,IB);
    
    
    % Get element disp.
    dg = zeros(NDE,1);
    dg(LDOF)=DELTA(GDOF);  
    
    % Transform into local coordindate
   
    DSL = T *dg;
    
    %     Compute the member forces
    %     {ELFOR}=[EE]{DSL}       (if IFORCE .EQ. 1)
    %     {ELFOR}=[EE]{DSL}+{FEF} (if IFORCE .EQ. 2)
    if IFORCE == 1
            ELFOR(:,IB) = EE * DSL;
    end
        
    if IFORCE == 2
            ELFOR(:,IB) = EE * DSL + FEF(:,IB);
    end
    
   

    
    
end
end

function OUTPUT(IWRITE,TITLE,FILENAME,FTYPE,FUNIT,LUNIT,startTime,endTime,...
    NNOD,NBC,NMAT,NSEC,NEQ,NCO,NDN,NNE,ITP,COOR,NFIX,PROP,SECT,IDBC,IDND,...
    VECTY,EXLD,IFORCE,FEF,DELTA,ELFOR,NSBAND)
%..........................................................................
%   PURPOSE: 1) write out all the structural input data for verification
%            2) show the results
%
%                          LIST OF VARIABLES
%
%                               -ARRAY-
%           /Real/
%         COOR(NCO,NNOD)  = nodal coordinates
%         DELTA(NEQ)      = nodal displacement vector
%         EXLD(NDN,NNOD)  = external load matrix
%         GLOAD(NEQ)      = nodal load vector
%         PROP(5,NMAT)    = material properties
%         SECT(5,NSEC)    = beam column properties
%         VECTY(NCO,NBC)  = direction of the weak axis for each member
%         DSG(NDN,NNOD)   = nodal displacements of each node
%         ELFOR(NDE,NBC)  = member forces in local coordinates
%         FEF(NDE,NBC)    = fixed end force in local coordinates
%         startTime       = start time
%         endTime         = end time
%
%           /Integer/
%         IDBC(8,NBC)     = beam column id number
%         IDND(NDN,NNOD)  = equation id number of nodes
%         LM(NDE,NBC)     = element location matrix
%         NFIX(NDN,NNOD)  = boolian id matrix to give boundary conditions
%
%                               -SCALAR-
%           /Integer/
%         ITP      = frame type number
%         NBC      = number of beam-column elements
%         NCO      = number of coordinates per node
%         NDE      = number of d.o.f. per element
%         NDN      = number of d.o.f per node
%         NEQ      = equation number
%         NMAT     = number of material types
%         NNOD     = number of nodes
%         NNE      = number of nodes per element
%         NSEC     = number of section types
%         NSBAND   = semi-bandwidth of stiffness matrix
%
%           /String/
%         FILENAME = filename
%         FTYPE    = frame type name
%         FUNIT    = force unit
%         LUNIT    = length unit
%         TITLE    = project name
%..........................................................................
% Header
fprintf(IWRITE,'%52s\r\n','MATRIX STRUCTURAL ANALYSIS');
fprintf(IWRITE,'%46s\r\n','December, 2013');
fprintf(IWRITE,'%29s%s\r\n','For the course : ','Advanced Structural Theory');
fprintf(IWRITE,'%29s%s\r\n','Programmer(s)  : ','R06521211林玟慧，R06521218劉德鈞 (Version 1.0)');
fprintf(IWRITE,'%29s%s\r\n','Supervised by  : ','Dr. Liang-Jenq Leu');
fprintf(IWRITE,'%55s\r\n','Dept. of Civil Engineering');
fprintf(IWRITE,'%55s\r\n','National Taiwan University');
fprintf(IWRITE,' %s\r\n',char(ones(1,77)*'='));
% Info
fprintf(IWRITE,' Project name   : %s\r\n',strtrim(TITLE));
fprintf(IWRITE,' File analyzed  : %s.ipt\r\n',FILENAME);
fprintf(IWRITE,' Output file    : %s.dat\r\n',FILENAME);
fprintf(IWRITE,' Frame type     : %s\r\n',FTYPE{ITP});
fprintf(IWRITE,' Execution date  : %s\r\n',datestr(now,'yyyy/mm/dd'));
fprintf(IWRITE,' Unit of force  : %s\r\n',strtrim(FUNIT));
fprintf(IWRITE,' Unit of length : %s\r\n',strtrim(LUNIT));
fprintf(IWRITE,' Total Program Running Time :\r\n');
fprintf(IWRITE,' Hour  Min.  Sec. (1/100)Sec.\r\n');
time = str2num(datestr(etime(endTime,startTime)/86400,'HH,MM,SS,FFF'));
fprintf(IWRITE,' %2s%6s%6s%6s\r\n',num2str(time(1)),num2str(time(2)),num2str(time(3)),num2str(round(time(4)/10)));
fprintf(IWRITE,' %s\r\n\r\n',char(ones(1,77)*'_'));
% Problem scope
fprintf(IWRITE,' PROBLEM SCOPE\r\n\r\n');
fprintf(IWRITE,'%12s%12s%12s%12s%12s%10s\r\n','Number of','Number of','Number of','Number of','Number of','Semi-');
fprintf(IWRITE,'%10s%13s%14s%11s%9s%15s\r\n','Nodes','Members','Mat''l Types','Sections','DOFs','Bandwidth');
fprintf(IWRITE,' %s\r\n\r\n',char(ones(1,77)*'_'));
fprintf(IWRITE,'%8i%12i%12i%12i%12i%12i\r\n',NNOD,NBC,NMAT,NSEC,NEQ,NSBAND);
fprintf(IWRITE,' %s\r\n\r\n',char(ones(1,77)*'_'));
% Nodal information
fprintf(IWRITE,' NODAL INFORMATION\r\n\r\n');
fprintf(IWRITE,'%6s%31s%34s\r\n','Node','Nodal Coordinates','Nodal Fixity');
fprintf(IWRITE,'%6s%11s%12s%12s%14s%3s%5s%7s%3s%5s\r\n','Numb','X','Y','Z','X-tran','Y','Z','X-rot','Y','Z');
fprintf(IWRITE,'%6s%39s%33s\r\n',char(ones(1,4)*'-'),char(ones(1,33)*'-'),char(ones(1,27)*'-'));
switch ITP
    case 1, format = '%5i%16.3E%37i%20i\r\n';
    case 2, format = '%5i%16.3E%12.3E%20i%5i\r\n';
    case 3, format = '%5i%16.3E%12.3E%20i%5i%20i\r\n';
    case 4, format = '%5i%16.3E%23.3E%14i%10i%10i\r\n';
    case 5, format = '%5i%16.3E%12.3E%12.3E%8i%5i%5i\r\n';
    case 6, format = '%5i%16.3E%12.3E%12.3E%8i%5i%5i%5i%5i%5i\r\n';
end
for i = 1:NNOD
    fprintf(IWRITE,format,i,COOR(:,i),NFIX(:,i));
end
fprintf(IWRITE,' %s\r\n\r\n',char(ones(1,77)*'_'));
% Material properities
fprintf(IWRITE,' MATERIAL PROPERTIES\r\n\r\n');
fprintf(IWRITE,'%30s%8s%23s\r\n','Mat''l Type','E','Poisson''s Ratio');
fprintf(IWRITE,'%30s%32s\r\n',char(ones(1,10)*'-'),char(ones(1,29)*'-'));
for i = 1:NMAT
    fprintf(IWRITE,'%26i%16.3E%15.3E\r\n',i,PROP(1:2,i));
end
fprintf(IWRITE,' %s\r\n\r\n',char(ones(1,77)*'_'));
% Section properities
fprintf(IWRITE,' SECTION PROPERTIES\r\n\r\n');
fprintf(IWRITE,'%20s%10s%11s%12s%11s\r\n','Sect. Type','Area','Iz','Iy','J');
fprintf(IWRITE,'%20s%49s\r\n',char(ones(1,10)*'-'),char(ones(1,46)*'-'));
for i = 1:NSEC
    fprintf(IWRITE,'%16i%16.3E%12.3E%12.3E%12.3E\r\n',i,SECT(1:4,i));
end
fprintf(IWRITE,' %s\r\n\r\n',char(ones(1,77)*'_'));
% Member information
fprintf(IWRITE,' MEMBER INFORMATION\r\n\r\n');
fprintf(IWRITE,'%8s%14s%9s%8s%38s\r\n','Member','Node Numb','Mat''l','Sect.','Directional Cosines for Weak Axis');
fprintf(IWRITE,'%7s%9s%7s%8s%8s%12s%12s%12s\r\n','Numb','End-I','End-J','Type','Type','X-dir','Y-dir','Z-dir');
fprintf(IWRITE,'%8s%15s%16s%39s\r\n',char(ones(1,6)*'-'),char(ones(1,12)*'-'),char(ones(1,13)*'-'),char(ones(1,36)*'-'));
for i = 1:NBC
    fprintf(IWRITE,'%6i%9i%7i%7i%8i',i,IDBC(1:4,i));
    if ITP == 6
        fprintf(IWRITE,'%16.3E%12.3E%12.3E',VECTY(:,i)');
    end
    fprintf(IWRITE,'\r\n');
end
fprintf(IWRITE,' %s\r\n\r\n',char(ones(1,77)*'_'));
% Nodal loads
fprintf(IWRITE,' NODAL LOADS (Unit : %s)\r\n\r\n',strtrim(FUNIT));
fprintf(IWRITE,'%6s%23s%36s\r\n','Node','Forces','Moments');
fprintf(IWRITE,'%6s%8s%12s%12s%12s%12s%12s\r\n','Numb','X','Y','Z','X','Y','Z');
fprintf(IWRITE,'%6s%36s%36s\r\n',char(ones(1,4)*'-'),char(ones(1,33)*'-'),char(ones(1,33)*'-'));
switch ITP
    case 1, format = '%5i%25.3E%48.3E\r\n';
    case 2, format = '%5i%13.3E%12.3E\r\n';
    case 3, format = '%5i%13.3E%12.3E%48.3E\r\n';
    case 4, format = '%5i%25.3E%24.3E%24.3E\r\n';
    case 5, format = '%5i%13.3E%12.3E%12.3E\r\n';
    case 6, format = '%5i%13.3E%12.3E%12.3E%12.3E%12.3E%12.3E\r\n';
end
for i = 1:NNOD
    if ~isempty(find(EXLD(:,i)))
        fprintf(IWRITE,format,i,EXLD(:,i));
    end
end
fprintf(IWRITE,' %s\r\n\r\n',char(ones(1,77)*'_'));
% Fix end force
if IFORCE == 2
    fprintf(IWRITE,' FIXED END FORCES (Local Coordinates)\r\n');
    fprintf(IWRITE,'    (Force  : %s)\r\n',strtrim(FUNIT));
    fprintf(IWRITE,'    (Moment : %s-%s)\r\n\r\n',strtrim(FUNIT),strtrim(LUNIT));
    fprintf(IWRITE,'%6s%6s%21s%34s\r\n','Memb','Node','Force','Moment');
    fprintf(IWRITE,'%6s%6s%9s%11s%11s%11s%11s%11s\r\n','Numb','Numb','X''','Y''','Z''','X''','Y''','Z''');
    fprintf(IWRITE,'%6s%6s%33s%33s\r\n',char(ones(1,4)*'-'),char(ones(1,4)*'-'),char(ones(1,31)*'-'),char(ones(1,31)*'-'));
    switch ITP
        case 1, format = '%5i%6i%24.3E%44.3E\r\n';
        case 2, format = '%5i%6i%12.3E%12.3E\r\n';
        case 3, format = '%5i%6i%12.3E%12.3E%44.3E\r\n';
        case 4, format = '%5i%6i%23.3E%22.3E%22.3E\r\n';
        case 5, format = '%5i%6i%12.3E%11.3E%11.3E\r\n';
        case 6, format = '%5i%6i%12.3E%11.3E%11.3E%11.3E%11.3E%11.3E\r\n';
    end
    for j = 1:NBC
        for i = 1:NNE
            fprintf(IWRITE,format,j,IDBC(i,j),FEF((1:NDN)+(i-1)*NDN,j));
        end
    end
    fprintf(IWRITE,' %s\r\n\r\n',char(ones(1,77)*'_'));
end
% Nodal displacements
fprintf(IWRITE,' NODAL DISPLACEMENTS (Unit : %s)\r\n',strtrim(LUNIT));
fprintf(IWRITE,'%6s%26s%34s\r\n','Node','Displacement','Rotation');
fprintf(IWRITE,'%6s%8s%12s%12s%12s%12s%12s\r\n','Numb','X','Y','Z','X','Y','Z');
fprintf(IWRITE,'%6s%36s%36s\r\n',char(ones(1,4)*'-'),char(ones(1,33)*'-'),char(ones(1,33)*'-'));
switch ITP
    case 1, format = '%5i%25.3E%48.3E\r\n';
    case 2, format = '%5i%13.3E%12.3E\r\n';
    case 3, format = '%5i%13.3E%12.3E%48.3E\r\n';
    case 4, format = '%5i%25.3E%24.3E%24.3E\r\n';
    case 5, format = '%5i%13.3E%12.3E%12.3E\r\n';
    case 6, format = '%5i%13.3E%12.3E%12.3E%12.3E%12.3E%12.3E\r\n';
end
for j = 1:NNOD
    delta = zeros(1,NDN);
    for i = 1:NDN
        if IDND(i,j) > 0
            delta(i) = DELTA(IDND(i,j));
        end
    end
    fprintf(IWRITE,format,j,delta);
end
fprintf(IWRITE,' %s\r\n\r\n',char(ones(1,77)*'_'));
% Member forces
fprintf(IWRITE,' MEMBER FORCES (Local Coordinates)\r\n');
fprintf(IWRITE,'    (Force  : %s)\r\n',strtrim(FUNIT));
fprintf(IWRITE,'    (Moment : %s-%s)\r\n\r\n',strtrim(FUNIT),strtrim(LUNIT));
fprintf(IWRITE,'%6s%6s%21s%34s\r\n','Memb','Node','Force','Moment');
fprintf(IWRITE,'%6s%6s%9s%11s%11s%11s%11s%11s\r\n','Numb','Numb','X''','Y''','Z''','X''','Y''','Z''');
fprintf(IWRITE,'%6s%6s%33s%33s\r\n',char(ones(1,4)*'-'),char(ones(1,4)*'-'),char(ones(1,31)*'-'),char(ones(1,31)*'-'));
switch ITP
    case 1, format = '%5i%6i%24.3E%44.3E\r\n';
    case 2, format = '%5i%6i%12.3E%12.3E\r\n';
    case 3, format = '%5i%6i%12.3E%12.3E%44.3E\r\n';
    case 4, format = '%5i%6i%23.3E%22.3E%22.3E\r\n';
    case 5, format = '%5i%6i%12.3E%11.3E%11.3E\r\n';
    case 6, format = '%5i%6i%12.3E%11.3E%11.3E%11.3E%11.3E%11.3E\r\n';
end
for j = 1:NBC
    for i = 1:NNE
        fprintf(IWRITE,format,j,IDBC(i,j),ELFOR((1:NDN)+(i-1)*NDN,j));
    end
end
fprintf(IWRITE,' %s\r\n',char(ones(1,77)*'_'));
end

function GRAPHOUTPUT(IGW,COOR,NFIX,EXLD,IDBC,FEF,PROP,SECT,LM,IDND,DELTA,ELFOR,NNOD,...
    NDN,NCO,NDE,NEQ,NBC,NMAT,NSEC,ITP,NNE,IFORCE,FUNIT,LUNIT)
if ITP <=2
    format1 = '%3i  %3i\r\n';
    format2 = '%13.4f  %13.4f  %13.4f  %13.4f\r\n';
    format3 = '%13.4f  %13.4f\r\n';
else
    format1 = '%3i  %3i  %3i\r\n';
    format2 = '%13.4f  %13.4f  %13.4f  %13.4f  %13.4f  %13.4f\r\n';
    format3 = '%13.4f  %13.4f  %13.4f\r\n';
end
fprintf(IGW,'%3i  %3i  %3i  %3i  %3i  %3i  %3i\r\n',NNOD,NBC,NMAT,NSEC,ITP,NNE,IFORCE);
for i = 1:NNOD
    if ITP == 1
        fprintf(IGW,'%3i  %13.4f 0\r\n',i,COOR(:,i));
    elseif ITP >= 2 && ITP <= 4
        fprintf(IGW,'%3i  %13.4f  %13.4f\r\n',i,COOR(:,i));
    else
        fprintf(IGW,'%3i  %13.4f  %13.4f  %13.4f\r\n',i,COOR(:,i));
    end
end
for i = 1:NNOD
    fprintf(IGW,format1,NFIX(:,i));
end
for i = 1:NNOD
    fprintf(IGW,format3,EXLD(:,i));
end
for i = 1:NBC
    fprintf(IGW,'%3i  %3i  %3i  %3i  %3i\r\n',IDBC(:,i));
end
if IFORCE == 2
    for i = 1:NBC
        fprintf(IGW,format2,FEF(:,i));
    end
end
for i = 1:NMAT
    fprintf(IGW,'%15.5f  %15.5f  %8.2f  %8.2f  %8.2f\r\n',PROP(:,i));
end
for i = 1:NSEC
    fprintf(IGW,'%15.5f  %15.5f  %15.5f  %8.2f  %8.2f\r\n',SECT(:,i));
end
for j = 1:NNOD
    DSG = zeros(NDN,1);
    for i = 1:NDN
        if IDND(i,j) > 0
            if abs(DELTA(IDND(i,j))) > 1e-10
                DSG(i) = DELTA(IDND(i,j));
            end
        end
    end
    fprintf(IGW,format3,DSG);
end
for i = 1:NBC
    if ITP ~= 1 && ITP ~= 4
        ELFOR(1,i) = -ELFOR(1,i);
    end
    fprintf(IGW,format3,ELFOR(1:NDN,i));
end
fprintf(IGW,' %s\r\n %s\r\n',strtrim(FUNIT),strtrim(LUNIT));
end