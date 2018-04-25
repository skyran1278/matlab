function displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements)
%
% displacements = inv(stiffness) / force.
%
% @since 1.0.1
% @param {number} [G_dof] total number of degrees of freedom.
% @param {array} [prescribed_dof] 有束制的節點.
% @param {array} [stiffness] stiffness.
% @param {array} [force] force.
% @param {array} [displacements] initial displacements.
% @return {array} [displacements] displacements.
%

    % function to find solution in terms of global displacements
    active_dof = setdiff((1 : G_dof)', prescribed_dof);

    % 這裡的感覺應該是束制的 displacements，對於沒束制的影響
    % 類似 fef
    eq_force = stiffness(prescribed_dof, active_dof).' * displacements(prescribed_dof);

    % 只計算沒束制的自由度
    U = stiffness(active_dof, active_dof) \ (force(active_dof) - eq_force);

    displacements(active_dof) = U;

end
