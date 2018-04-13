clc; clear; close all;

[node_coordinates, displacements, stress] = exact_solution();


[node_1, disp_1, stress_1] = output_node_disp_and_stress_by_fem(1);
[node_2, disp_2, stress_2] = output_node_disp_and_stress_by_fem(2);
[node_4, disp_4, stress_4] = output_node_disp_and_stress_by_fem(4);
[node_8, disp_8, stress_8] = output_node_disp_and_stress_by_fem(8);
[node_16, disp_16, stress_16] = output_node_disp_and_stress_by_fem(16);

% stairs(node_coordinates, stress)
figure;
plot(node_1, disp_1, '-oc', node_2, disp_2, ':*b', node_4, disp_4, '-sg', node_8, disp_8, '-om', node_16, disp_16, ':*r', node_coordinates, displacements, '-k');
legend('1 element', '2 element', '4 element', '8 element', '16 element', 'exact solution', 'Location', 'northwest');
title('displacement vs. from exact solution and from 1, 2, 4, 8, 16 elements');
xlabel('x (m)');
ylabel('displacement (m)');


figure;
stairs(node_1, stress_1, '-oc');
hold on;
stairs(node_2, stress_2, ':*b');
hold on;
stairs(node_4, stress_4, '-sg');
hold on;
stairs(node_8, stress_8, '-om');
hold on;
stairs(node_16, stress_16, ':*r');
hold on;
plot(node_coordinates, stress, '-k');

legend('1 element', '2 element', '4 element', '8 element', '16 element', 'exact solution', 'Location', 'northeast');
title('stress vs. from exact solution and from 1, 2, 4, 8, 16 elements');
xlabel('x (m)');
ylabel('stress (N/m^2)');
