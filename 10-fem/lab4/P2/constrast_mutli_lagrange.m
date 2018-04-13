% lagrange 比較準，但速度較慢。

clc; clear; close all;

[node_coordinates, displacements, stress] = exact_solution();

[node_1, disp_1, stress_1] = output_node_disp_and_stress_by_fem(1);
[node_2, disp_2, stress_2] = output_node_disp_and_stress_by_fem(2);
[node_4, disp_4, stress_4] = output_node_disp_and_stress_by_fem(4);
[node_8, disp_8, stress_8] = output_node_disp_and_stress_by_fem(8);
[node_16, disp_16, stress_16] = output_node_disp_and_stress_by_fem(16);

sum_diff = 0;
nodes = {node_1, node_2, node_4, node_8, node_16};
disps = {disp_1, disp_2, disp_4, disp_8, disp_16};

for index = 1 : length(nodes)

    [~, index_node] = intersect(node_coordinates, nodes{index});

    sum_diff = sum_diff + sum((displacements(index_node) - disps{index}.') .^ 2);

end

[node_lagrange_1, disp_lagrange_1] = output_node_disp_by_lagrange(1);
[node_lagrange_2, disp_lagrange_2] = output_node_disp_by_lagrange(2);
[node_lagrange_4, disp_lagrange_4] = output_node_disp_by_lagrange(4);
[node_lagrange_8, disp_lagrange_8] = output_node_disp_by_lagrange(8);
[node_lagrange_16, disp_lagrange_16] = output_node_disp_by_lagrange(16);

sum_diff_lagrange = 0;
nodes = {node_lagrange_1, node_lagrange_2, node_lagrange_4, node_lagrange_8, node_lagrange_16};
disps = {disp_lagrange_1, disp_lagrange_2, disp_lagrange_4, disp_lagrange_8, disp_lagrange_16};

for index = 1 : length(nodes)

    [~, index_node] = intersect(node_coordinates, nodes{index});

    sum_diff_lagrange = sum_diff_lagrange + sum((displacements(index_node) - disps{index}.') .^ 2);

end

if sum_diff_lagrange < sum_diff
    disp('lagrange better');
else
    disp('elements better');
end
