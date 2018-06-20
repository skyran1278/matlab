%................................................................

function displacements=solution(displacements, GDof,prescribedDof,stiffness,force)
% function to find solution in terms of global displacements
activeDof=setdiff([1:GDof]', ...
    [prescribedDof]);
U=stiffness(activeDof,activeDof)\(force(activeDof)-stiffness(activeDof,prescribedDof)*displacements(prescribedDof));
% displacements=zeros(GDof,1);
displacements(activeDof)=U;
% displacements(3)=1e-6;