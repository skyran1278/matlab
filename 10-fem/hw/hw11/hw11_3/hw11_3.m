clc; clear; close all;

number_elements = 1;
number_nodes = 8;
element_nodes = [1 2 3 4 5 6 7 8];
node_coordinates = [0 5; 5/sqrt(2) 5/sqrt(2); 5 0; 10 0; 15 0; 15/sqrt(2) 15/sqrt(2); 0 15; 0 10];

% 一個 element 有幾個 nodes
num_node_per_element = size(element_nodes, 2);

shape_function = create_shape_function(num_node_per_element, 'along_boundry');

% 一個 element 有幾個自由度
num_e_dof = 2 * num_node_per_element;

e = 1;

xi = 0.5;
eta = 0.5;

% 輸出的已經是數值了
[~, diff_shape] = shape_function(xi, eta);

% number array
[~, ~, diff_shape_xy] = form_jacobian(node_coordinates(element_nodes(e, :), :), diff_shape);

% 應該要拆出來比較合理，不過算了。
% 已經是數值了
B = zeros(3, num_e_dof);

% x 0 x 0 ...
B(1, 1 : 2 : num_e_dof) = diff_shape_xy(1, :);

% 0 y 0 y ...
B(2, 2 : 2 : num_e_dof) = diff_shape_xy(2, :);

% y x y x ...
B(3, 1 : 2 : num_e_dof) = diff_shape_xy(2, :);
B(3, 2 : 2 : num_e_dof) = diff_shape_xy(1, :);

B
