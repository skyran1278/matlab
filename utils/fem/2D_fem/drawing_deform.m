function [] = drawing_deform(node_coordinates, element_nodes, displacements)
%
% drawing deform shape.
%
% @since 1.0.0
% @param {array} [node_coordinates] �`�I��m.
% @param {array} [element_nodes] �C�Ӥ������X�Ӹ`�I�A�٦��L�̪����G.
% @param {type} [displacements] description.
% @param {array} [displacements] displacements.
% @see drawing_mesh
%

    displacement_reshape = reshape(displacements, 2, []).';

    figure;

    drawing_mesh(node_coordinates, element_nodes, 'k-o');

    hold on;

    drawing_mesh(node_coordinates + displacement_reshape, element_nodes, 'r:');

end
