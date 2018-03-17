function GRAPHOUTPUT(IGW, COOR, NFIX, EXLD, IDBC, FEF, PROP, SECT, LM, IDND, DELTA, ELFOR, NNOD, ...
    NDN, NCO, NDE, NEQ, NBC, NMAT, NSEC, ITP, NNE, IFORCE, FUNIT, LUNIT)
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