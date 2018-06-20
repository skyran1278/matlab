%................................................................

function outputDisplacements...
    (displacements,numberNodes,GDof)

% output of displacements in tabular form

disp('Q8')
jj=[40 40 40]; format
jjj=[0 1 2]; format
f=[jj; jjj; displacements([17 27 45])'; displacements([18 28 46])'];
fprintf('x-coor     y-coor      UX           UY\n')
fprintf('%4d   %4d   %10.4e    %10.4e\n',f)