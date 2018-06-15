function displacements = solution(gDof, prescribedDof, stiffness, force, displacements)
%
% displacements = inv(stiffness) / force.
%
% @since 2.1.0
% @param {number} [gDof] total number of degrees of freedom.
% @param {array} [prescribedDof] �����`�I.
% @param {array} [stiffness] stiffness.
% @param {array} [force] force.
% @param {array} [displacements] initial displacements.
% @return {array} [displacements] displacements.
%
    if nargin == 4
        displacements = zeros(gDof, 1);
    end

    % function to find solution in terms of global displacements
    activeDof = setdiff((1 : gDof)', prescribedDof);

    % �o�̪��Pı���ӬO�� displacements�A���S���v�T
    % fef
    fef = stiffness(prescribedDof, activeDof).' * displacements(prescribedDof);

    % �u�p��S���ۥѫ�
    U = stiffness(activeDof, activeDof) \ (force(activeDof) - fef);

    displacements(activeDof) = U;

end
