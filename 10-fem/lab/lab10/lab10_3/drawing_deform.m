function [] = drawing_deform(node_coordinates, element_nodes, displacements, magnification_factor)
%
% drawing deform shape.
%
% @since 1.2.0
% @param {array} [node_coordinates] 節點位置.
% @param {array} [element_nodes] 每個元素有幾個節點，還有他們的分佈.
% @param {type} [displacements] description.
% @param {array} [displacements] displacements.
% @param {number} [magnification_factor] 放大係數.
% @see drawing_mesh
%

    if nargin == 3
        magnification_factor = max(max(node_coordinates) - min(node_coordinates)) / max(abs(displacements)) * 0.1;
    end

    displacement_reshape = reshape(displacements, 2, []).' * magnification_factor;

    figure;

    undeformed_mesh = drawing_mesh(node_coordinates, element_nodes, 'k-o');

    hold on;

    deformed_mesh = drawing_mesh(node_coordinates + displacement_reshape, element_nodes, 'r-o');

    legend([undeformed_mesh, deformed_mesh], 'undeformed', 'deformed', 'Location', 'northeast');

end
