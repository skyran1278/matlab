function displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements)
%
% displacements = inv(stiffness) / force.
%
% @since 1.0.0
% @param {number} [G_dof] total number of degrees of freedom.
% @param {array} [prescribed_dof] 有束制的節點.
% @param {array} [stiffness] stiffness.
% @param {array} [force] force.
% @param {array} [displacements] initial displacements.
% @return {array} [displacements] displacements.
%

    % function to find solution in terms of global displacements
    activeDof = setdiff((1 : G_dof)', prescribed_dof);

    eq_force = stiffness(prescribed_dof, activeDof).' * displacements(prescribed_dof);

    U = stiffness(activeDof, activeDof) \ (force(activeDof) - eq_force);

    displacements(activeDof) = U;

end
