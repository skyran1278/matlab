function [] = drawing_deform(node_coordinates, element_nodes, displacements, magnification_factor)
%
% drawing deform shape.
%
% @since 1.0.0
% @param {array} [node_coordinates] �`�I��m.
% @param {array} [element_nodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @param {type} [displacements] description.
% @param {array} [displacements] displacements.
% @param {number} [magnification_factor] ��j�Y��.
% @see drawing_mesh
%

    displacement_reshape = reshape(displacements, 2, []).' * magnification_factor;

    figure;

    fig1 = drawing_mesh(node_coordinates, element_nodes, 'k-o');

    legend({'undeformed', 'deformed'}, 'Location', 'northeast');

    hold on;

    fig2 = drawing_mesh(node_coordinates + displacement_reshape, element_nodes, 'r:');

    legend([fig1, fig2], 'undeformed', 'deformed', 'Location', 'northeast');

end
