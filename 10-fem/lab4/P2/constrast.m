% lagrange ¤ñ¸û·Ç

clc; clear; close all;

[node_coordinates, displacements, stress] = exact_solution();


[node_1, disp_1, stress_1] = output_node_disp_and_stress_by_fem(1);
[node_2, disp_2, stress_2] = output_node_disp_and_stress_by_fem(2);
[node_4, disp_4, stress_4] = output_node_disp_and_stress_by_fem(4);
[node_8, disp_8, stress_8] = output_node_disp_and_stress_by_fem(8);
[node_16, disp_16, stress_16] = output_node_disp_and_stress_by_fem(16);

% stairs(node_coordinates, stress)
% figure;
% plot(node_1, disp_1, '-oc', node_2, disp_2, ':*b', node_4, disp_4, '-sg', node_8, disp_8, '-om', node_16, disp_16, ':*r', node_coordinates, displacements, '-k');
% legend('1 element', '2 element', '4 element', '8 element', '16 element', 'exact solution', 'Location', 'northwest');
% title('displacement vs. from exact solution and from 1, 2, 4, 8, 16 elements');
% xlabel('x (m)');
% ylabel('displacement (m)');

sum_diff = 0;
nodes = {node_1, node_2, node_4, node_8, node_16};
disps = {disp_1, disp_2, disp_4, disp_8, disp_16};

for index = 1 : length(nodes)

    [~, index_node] = intersect(node_coordinates, nodes{index});

    sum_diff = sum_diff + sum((displacements(index_node) - disps{index}.') .^ 2);

end

[node_constrast_1, disp_constrast_1] = output_node_disp_by_lagrange(1);
[node_constrast_2, disp_constrast_2] = output_node_disp_by_lagrange(2);
[node_constrast_4, disp_constrast_4] = output_node_disp_by_lagrange(4);
[node_constrast_8, disp_constrast_8] = output_node_disp_by_lagrange(8);
[node_constrast_16, disp_constrast_16] = output_node_disp_by_lagrange(16);

sum_diff_constrast = 0;
nodes = {node_constrast_1, node_constrast_2, node_constrast_4, node_constrast_8, node_constrast_16};
disps = {disp_constrast_1, disp_constrast_2, disp_constrast_4, disp_constrast_8, disp_constrast_16};

for index = 1 : length(nodes)

    [~, index_node] = intersect(node_coordinates, nodes{index});

    sum_diff_constrast = sum_diff_constrast + sum((displacements(index_node) - disps{index}.') .^ 2);

end

if sum_diff - sum_diff_constrast > 0
    disp('lagrange better');
else
    disp('elements better');
end
