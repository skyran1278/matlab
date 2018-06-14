function [] = outputReaction(displacements, stiffness, prescribedDof, force)
%
% output of reactions in tabular form.
%
% @since 1.0.0
% @param {array} [displacements] displacements.
% @param {array} [stiffness] stiffness.
% @param {array} [prescribedDof] 有束制的節點.
% @param {array} [force] force.
%

    % reactions
    F = stiffness * displacements;
    reactions = F(prescribedDof) - force(prescribedDof);

    disp('Reactions');
    fprintf('node        reactions\n');

    for index = 1 : size(prescribedDof, 1)
        fprintf('%2.0f:%20.4e\n', prescribedDof(index), reactions(index));
    end

end
