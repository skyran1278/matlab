function FRAME17(FILENAME)
% FRAME17: A linear analysis program for framed structures
%..........................................................................
%    Programmer:  劉德謙、乃宥然
%                 Supervised by Professor Liang-Jenq Leu
%                 For the course: Advanced Structural Theory
%                 Department of Civil Engineering
%                 National Taiwan University
%                 Fall 2017 @All Rights Reserved
%..........................................................................

%    VARIABLES:
%        NNOD   = number of nodes 幾個節點
%        NBC    = number of Beam-column elements 幾個桿件
%        NCO    = number of coordinates per node 幾個維度
%        NDN    = number of DOFs per node 有幾個自由度
%        NNE    = number of nodes per element 一個桿件有幾個節點
%        NDE    = number of DOFs per element 一個桿件有幾個自由度
%        NMAT   = number of material types 材料種類
%        NSEC   = number of cross-sectional types 斷面
%        IFORCE = 1 if only concentrated loads are applied
%               = 2 if fixed-end forces are required. 非集中力的時候需要修正
%                   (e.g. problems with distributed loads, fabrication
%                   errors, temperature change, or support settlement)
%    CHARACTERS
%        FUNIT  = unit of force (such as kN and kip)
%        LUNIT  = unit of length (such as mm and in)
%..........................................................................

%    FRAME TYPE    ITP  NCO  NDN   (NCO and NDN are stored in Array IPR)
%           BEAM    1    1    2    (Y, thetaZ)
%   PLANAR  TRUSS   2    2    2    (X, Y)
%   PLANAR  FRAME   3    2    3    (X, Y, thetaZ)
%   PLANAR  GRID    4    2    3    (Y, thetaX, thetaZ)
%   SPACE   TRUSS   5    3    3    (X, Y, Z)
%   SPACE   FRAME   6    3    6    (X, Y, Z, thetaX, thetaY, thetaZ)

FTYPE = {'BEAM'; 'PLANE TRUSS'; 'PLANE FRAME'; 'PLANE GRID'; 'SPACE TRUSS'; 'SPACE FRAME'};
IPR = [ 1, 2, 2, 2, 3, 3; ...
    2, 2, 3, 3, 3, 6 ];

if nargin == 0 % no input argument
    % Open file with user interface
    [~, FILENAME] = fileparts(uigetfile('*.ipt', 'Select Input file'));
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
HeadLine(ID,IREAD);

line = fgets(IREAD);
args = str2num(line); % 可回傳 matrix
[NNOD, NBC, NMAT, NSEC, ITP, NNE, IFORCE] = deal(args(1), args(2), args(3), args(4), args(5), args(6), args(7));
NCO = IPR(1, ITP);
NDN = IPR(2, ITP);
NDE = NDN * NNE;

% Read the remaining data
[COOR, NFIX, EXLD, IDBC, VECTY, FEF, PROP, SECT] = ...
    INPUT(FILENAME, TITLE, FUNIT, LUNIT, IREAD, ID, NNOD, NBC, NMAT, NSEC, ITP, NCO, NDN, NDE, IFORCE, NNE);

fclose(IREAD);

% DrawingStructure
FORMAT = '-';
DrawingStructure(ITP, COOR, IDBC, NBC, LUNIT, FORMAT);


% ^^* UP TO HERE  --- PROG 1 ^^*


% DOF numbering
% IDND(Matrix)：由 NFIX 累加自由度的 matrix
% NEQ(Integer)：總共幾條方程式
[IDND, NEQ] = IDMAT(NFIX, NNOD, NDN);

% Compute the member DOF table:  LM(NDE,NBC)
% LM(Matrix)：把 IDND 從節點自由度換成桿件自由度
LM = MEMDOF(NDE, NBC, IDBC, IDND);

% Compute the semi-band width,NSBAND, of the global stiffness matrix
% NSBAND(Integer)：帶寬
NSBAND = SEMIBAND(LM);

% Form the global load vector GLOAD(NEQ) from the concentrated nodal loads
% GLOAD(Array)：把集中力轉換成方程式型態
GLOAD = LOAD(EXLD, IDND, NDN, NNOD, NEQ);

% ^^* UP TO HERE  --- PROG 2 ^^*


GLOAD = ModifyGLOAD(GLOAD, IDND);


% Form the global stiffness matrix GLK(NEQ,NSBAND) and obtain the
% equivalent nodal vector by assembling -(fixed-end forces) of each member
% into the load vector.
% GLK(Matrix)：Assemble Stiffness
% GLOAD(Array)：FEF 修正集中力
[GLK, GLOAD] = FORMKP(COOR, IDBC, VECTY, PROP, SECT, LM, FEF, GLOAD, NNOD, NBC, NMAT, NSEC, IFORCE, ITP, NCO, NDN, NDE, NNE, NEQ);

% ^^* UP TO HERE  --- PROG 3 ^^*

% DELTA(Array)：delta => K * delta = P
DELTA = SOLVE(GLK, GLOAD);

% Determine the member end forces ELFOR(NDE,NBC)
% ELFOR(Matrix)：內力
ELFOR = FORCE(COOR, IDBC, VECTY, PROP, SECT, LM, FEF, GLOAD, NNOD, NBC, NMAT...
    , NSEC, IFORCE, ITP, NCO, NDN, NDE, NNE, NEQ, DELTA);

CalAxialForce7(ELFOR);
% Get ending time and count the elapased time
endTime = clock;

% Print out the results
IWRITE = fopen([FILENAME '.dat'], 'w');
OUTPUT(IWRITE, TITLE, FILENAME, FTYPE, FUNIT, LUNIT, startTime, endTime, ...
    NNOD, NBC, NMAT, NSEC, NEQ, NCO, NDN, NNE, ITP, COOR, NFIX, PROP, SECT, IDBC, IDND, ...
    VECTY, EXLD, IFORCE, FEF, DELTA, ELFOR, NSBAND);
fclose(IWRITE);

IGW = fopen([FILENAME '.txt'], 'w');
GRAPHOUTPUT(IGW,COOR,NFIX,EXLD,IDBC,FEF,PROP,SECT,LM,IDND,DELTA,ELFOR,NNOD,...
    NDN,NCO,NDE,NEQ,NBC,NMAT,NSEC,ITP,NNE,IFORCE,FUNIT,LUNIT);
fclose(IGW);

% ^^* UP TO HERE  --- PROG 4 ^^*

end
