%
%     Advanced Structural Theory
%
%     Program Assignment No. 4 (weight=3)
%           (12/7/2017)
%       Due: 12/21/2017
%
%      1. Complete the main program FRAME17
%      2. Complete function FORCE   
%      3. Complete adding FEF in function FORMKP
%      4. Function OUTPUT has been completed except that one line
%         that is marked needs to be adjusted.
%      5. Run the following examples:
%         (1) All the examples you did for the PROG3 assignments.
%         (2) Other examples:
%            a. ITP=1: example 5.11 (page 124) but with 
%			          ab=5m and bc=2m and settlement=12 mm. 
%            b. ITP=2: example 5.12 (page 127) 
%            c. ITP=3: example 5.3 (page 102) considering that a uniformly
%                      distributed load of 25 kN/m is applied downward 
%                      on member bc and 10 kN/m on member cd. 
%               * Calculate the P_eq by assembling the (-f_fef) and compare
%                  it with that obtained from your program.
%             d. ITP=5: Consider example 5.4 on page 104 assuming there are 
%                       no external loads at node a and the temperature in each member
%                       has a raise of 25 degrees. Assume that the coefficient of
%                      thermal expansion= 1.2*10^-5.
%             e. ITP=6: Consider the four cases on page 69 of Ch. 8 of course notes
%                       with the following data: (F-unit: N; L-unit cm)
%                       Coordinate: node 1 (0,0,0), 2 (0, 900, 0)
%                       Material/Section: E=9500 N/cm^2, A=16 cm^2, I_1=28 cm^4, 
%                                         I_2=9 cm^4, J=25 cm^4.
%                       Boundary conditions: 1-fixed 2-free with the applied loads
%                         (global dir) of F_Y2=550 N and F_Z2=2500 N 
%                       * You shall obtain the same displacements and rotations 
%                         for all the four cases.
%
%
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
end

function ELFOR = FORCE( ... )
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
    [T,RL] = ROTATION( ... );
    % Calculate the element stiffness matrix, EE
    EE = ELKE( ... );
    % Get element DOF
    
    % ...
    
    % Get element disp.
    
    % ...
    
    % Transform into local coordindate
    
    % ...
    
    %     Compute the member forces
    %     {ELFOR}=[EE]{DSL}       (if IFORCE .EQ. 1)
    %     {ELFOR}=[EE]{DSL}+{FEF} (if IFORCE .EQ. 2)

    % ...
    
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
fprintf(IWRITE,'%29s%s\r\n','Programmer(s)  : ','YOUR NAMES (Version 1.0)');
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