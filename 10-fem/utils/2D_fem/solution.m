function displacements = solution(GDof, prescribedDof, stiffness, force, displacements)
%
% displacements = inv(stiffness) / force.
%
% @since 2.1.0
% @param {number} [GDof] total number of degrees of freedom.
% @param {array} [prescribedDof] 有束制的節點.
% @param {array} [stiffness] stiffness.
% @param {array} [force] force.
% @param {array} [displacements] initial displacements.
% @return {array} [displacements] displacements.
%
    if nargin == 4
        displacements = zeros(GDof, 1);
    end

    % function to find solution in terms of global displacements
    activeDof = setdiff((1 : GDof)', prescribedDof);

    % 這裡的感覺應該是束制的 displacements，對於沒束制的影響
    % fef
    fef = stiffness(prescribedDof, activeDof).' * displacements(prescribedDof);

    % 只計算沒束制的自由度
    U = stiffness(activeDof, activeDof) \ (force(activeDof) - fef);

    displacements(activeDof) = U;

end
