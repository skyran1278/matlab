function [COOR, NFIX, EXLD, IDBC, VECTY, FEF, PROP, SECT] = INPUT(FILENAME, TITLE, FUNIT, LUNIT, IREAD, ID, NNOD, NBC, NMAT, NSEC, ITP, NCO, NDN, NDE, IFORCE, NNE)
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
HeadLine(ID, IREAD);
COOR = ReadMatrix(IREAD, NCO, NNOD);

% NFIX 束制條件
HeadLine(ID, IREAD);
NFIX = ReadMatrix(IREAD, NDN, NNOD);

% External Load 外力
HeadLine(ID, IREAD);
EXLD = ReadMatrix(IREAD, NDN, NNOD);

% IDBC 幾何形狀
HeadLine(ID, IREAD);
IDBC = ReadMatrix(IREAD, 5, NBC);

% VECTY
if ITP == 6
    HeadLine(ID, IREAD);
    VECTY = ReadMatrix(IREAD, 3, NBC);
else
    VECTY = [];
end

% IFORCE
if IFORCE == 2
    HeadLine(ID, IREAD);
    FEF = ReadMatrix(IREAD, NDE, NBC);
else
    FEF = [];
end

% PROP 材料性質
HeadLine(ID, IREAD);
PROP = ReadMatrix(IREAD, 5, NMAT);

% SECT 斷面大小
HeadLine(ID, IREAD);
SECT = ReadMatrix(IREAD, 5, NSEC);

%..........................................................................
% write out the input data to check

% PrintInputData(FILENAME, TITLE, FUNIT, LUNIT, NNOD, NBC, NMAT, NSEC, ITP, IFORCE, NNE, COOR, NFIX, EXLD, IDBC, VECTY, FEF, PROP, SECT);

%..........................................................................

end
