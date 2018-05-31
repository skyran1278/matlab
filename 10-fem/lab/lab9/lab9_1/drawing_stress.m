function [] = drawing_stress(element_nodes, node_coordinates, stress_gp_cell, stress_node_cell)
%
% drawing stress.
% average
% centroid
%
% @since 1.0.0
% @param {array} [element_nodes] 每個元素有幾個節點，還有他們的分佈.
% @param {array} [node_coordinates] 節點位置.
% @param {cell} [stress_gp_cell] stress on gauss point.
% @param {cell} [stress_node_cell] stress on node.
% @see drawing_patch
%

    number_elements = size(element_nodes, 1);
    number_nodes = size(node_coordinates, 1);

    accumulation_stress = zeros(number_nodes, 3);
    centroid_stress = zeros(number_elements, 3);

    accumulation_count = zeros(number_nodes, 1);

    % 畫平均 stress x
    for e = 1 : number_elements

        stress = stress_node_cell{e};

        accumulation_stress(element_nodes(e, :), :) = accumulation_stress(element_nodes(e, :), :) + stress;
        accumulation_count(element_nodes(e, :)) = accumulation_count(element_nodes(e, :)) + 1;

    end

    average_stress = accumulation_stress ./ accumulation_count;

    drawing_patch(node_coordinates, element_nodes, average_stress(:, 1));


    % 畫 centroid stress x
    for e = 1 : number_elements

        stress = stress_gp_cell{e};

        centroid_stress(e, :) = mean(stress, 1);

    end

    drawing_patch(node_coordinates, element_nodes, centroid_stress(:, 1));

end
