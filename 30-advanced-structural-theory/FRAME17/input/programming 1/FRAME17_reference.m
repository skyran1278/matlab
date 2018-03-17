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
%    Programmer:  YOUR NAMES 
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
IPR = [1,2,2,2,3,3;2,2,3,3,3,6];

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
% [COOR,~] = INPUT(IREAD,ID,NNOD,NCO,~);
fclose(IREAD);

% ^^* UP TO HERE  --- PROG 1 ^^*

% 
% % DOF numbering
% [IDND,NEQ] = IDMAT( ~ );
% 
% % Compute the member DOF table:  LM(NDE,NBC)
% LM = MEMDOF( ~ );
% 
% % Compute the semi-band width,NSBAND, of the global stiffness matrix
% NSBAND = SEMIBAND( ~ );
% 
% %Form the global load vector GLOAD(NEQ) from the concentrated nodal loads
% GLOAD = LOAD(EXLD, ~ );
% 
% % ^^* UP TO HERE  --- PROG 2 ^^*
% 
% % Form the global stiffness matrix GLK(NEQ,NSBAND) and obtain the
% % equivalent nodal vector by assembling -(fixed-end forces) of each member
% % into the load vector.
% [GLK,GLOAD] = FORMKP(COOR,IDBC,VECTY,PROP,SECT,LM,FEF,GLOAD,NNOD,NBC,NMAT...
%     ,NSEC,IFORCE,ITP,NCO,NDN,NDE,NNE,NEQ);
% 
% % ^^* UP TO HERE  --- PROG 3 ^^*
% 
% DISP = SOLVE(GLK, ~ );
% 
% % Determine the member end forces ELFOR(NDE,NBC)
% ELFOR = FORCE( ~ );
% 
% % Get ending time and count the elapased time
% endTime = clock;
% 
% % Print out the results
% IWRITE = fopen([FILENAME '.dat'], 'w');
% OUTPUT( ~ );
% fclose(IWRITE);
% 
% IGW = fopen([FILENAME '.txt'], 'w');
% GRAPHOUTPUT(IGW,COOR,NFIX,EXLD,IDBC,FEF,PROP,SECT,LM,IDND,DISP,ELFOR,NNOD,...
%     NDN,NCO,NDE,NEQ,NBC,NMAT,NSEC,ITP,NNE,IFORCE,FUNIT,LUNIT);
% fclose(IGW);
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

function [COOR ...
   ] = INPUT(IREAD,ID,NNOD,NCO ...
   )
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

% ...
% ...
% ...

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