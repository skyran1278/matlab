function displacements = solution(G_dof, prescribed_dof, stiffness, force, displacements)
%
% displacements = inv(stiffness) / force.
%
% @since 1.1.0
% @param {number} [G_dof] total number of degrees of freedom.
% @param {array} [prescribed_dof] ������`�I.
% @param {array} [stiffness] stiffness.
% @param {array} [force] force.
% @param {array} [displacements] initial displacements.
% @return {array} [displacements] displacements.
%
    if nargin == 4
        displacements = zeros(G_dof, 1);
    end
    % function to find solution in terms of global displacements
    active_dof = setdiff((1 : G_dof)', prescribed_dof);

    % �o�̪��Pı���ӬO��� displacements�A���S����v�T
    % fef
    fef = stiffness(prescribed_dof, active_dof).' * displacements(prescribed_dof);

    % �u�p��S����ۥѫ�
    U = stiffness(active_dof, active_dof) \ (force(active_dof) - fef);

    displacements(active_dof) = U;

end
