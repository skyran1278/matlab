function [] = output_reaction(displacements, stiffness, prescribed_dof, force)
%
% output of reactions in tabular form.
%
% @since 1.0.0
% @param {array} [displacements] displacements.
% @param {array} [stiffness] stiffness.
% @param {array} [prescribed_dof] 有束制的節點.
% @param {array} [force] force.
%

    % reactions
    F = stiffness * displacements;
    reactions = F(prescribed_dof) - force(prescribed_dof);

    disp('Reactions');
    fprintf('node        reactions\n');
    for index = 1 : size(prescribed_dof, 1)
        fprintf('%2.0f:%20.4e\n', prescribed_dof(index), reactions(index));
    end

end
