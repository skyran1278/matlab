%................................................................

function displacements = solution(GDof, prescribedDof, stiffness, force, displacements)

    if nargin == 4
        displacements = zeros(GDof, 1);
    end
    % function to find solution in terms of global displacements
    activeDof = setdiff((1 : GDof)', prescribedDof);

    eq_force = stiffness(prescribedDof, activeDof).' * displacements(prescribedDof);
    U = stiffness(activeDof, activeDof) \ (force(activeDof) - eq_force);

    displacements(activeDof) = U;

end
