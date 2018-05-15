function [] = output_displacements_reactions(displacements, stiffness, G_dof, prescribed_dof, force)
%
% output of displacements and reactions in tabular form.
%
% @since 1.0.1
% @param {array} [displacements] displacements.
% @param {array} [stiffness] stiffness.
% @param {number} [G_dof] total number of degrees of freedom.
% @param {array} [prescribed_dof] 有束制的節點.
% @param {array} [force] force.
%

    disp('Displacements');
    fprintf('node     displacements\n');

    % displacements
    for index = 1 : G_dof
        fprintf('%2.0f:        %10.4e\n', index, displacements(index));
    end

    % reactions
    F = stiffness * displacements;
    reactions = F(prescribed_dof) - force(prescribed_dof);

    disp('Reactions');
    fprintf('node     reactions\n');
    for index = 1 : size(prescribed_dof, 1)
        fprintf('%2.0f:        %10.4e\n', prescribed_dof(index), reactions(index));
    end

end
