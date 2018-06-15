function [] = outputDisplacements(displacements, numberNodes, gDof)
%
% output of displacements in tabular form.
%
% @since 1.0.0
% @param {array} [displacements] displacements.
% @param {number} [numberNodes] number of nodes.
% @param {number} [gDof] global number of degrees of freedom.
%

    disp('Displacements');
    fprintf('Node           UX           UY\n');
    fprintf('%4d%17.4e%17.4e\n', [1 : numberNodes; displacements(1 : 2 : gDof - 1)'; displacements(2 : 2 : gDof)'])

end
