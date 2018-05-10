function [] = output_displacements(displacements, number_nodes, G_dof)
%
% output of displacements in tabular form.
%
% @since 1.0.0
% @param {array} [displacements] displacements.
% @param {number} [number_nodes] number of nodes.
% @param {number} [G_dof] global number of degrees of freedom.
%

    disp('Displacements');
    fprintf('Node           UX           UY\n');
    fprintf('%4d%17.4e%17.4e\n', [1 : number_nodes; displacements(1 : 2 : G_dof - 1)'; displacements(2 : 2 : G_dof)'])

end
