clc; clear; close all;

syms xi eta; % be careful performance issue.

nodes = linspace(-1, 1, 3);

shape_xi_1 = lagrange_interpolation(nodes, 1, xi);
shape_xi_2 = lagrange_interpolation(nodes, 2, xi);
shape_xi_3 = lagrange_interpolation(nodes, 3, xi);
shape_eta_1 = lagrange_interpolation(nodes, 1, eta);
shape_eta_2 = lagrange_interpolation(nodes, 2, eta);
shape_eta_3 = lagrange_interpolation(nodes, 3, eta);

shape = sym(zeros(1, 9));
shape(1) = shape_xi_1 * shape_eta_1;
shape(2) = shape_xi_3 * shape_eta_1;
shape(3) = shape_xi_3 * shape_eta_3;
shape(4) = shape_xi_1 * shape_eta_3;
shape(5) = shape_xi_2 * shape_eta_1;
shape(6) = shape_xi_3 * shape_eta_2;
shape(7) = shape_xi_2 * shape_eta_3;
shape(8) = shape_xi_1 * shape_eta_2;
shape(9) = shape_xi_2 * shape_eta_2;

naturalDerivatives = sym(zeros(2, 9));
naturalDerivatives(1, :) = diff(shape, xi);
naturalDerivatives(2, :) = diff(shape, eta);

shapeQ16 = matlabFunction(shape);
naturalDerivativesQ16 = matlabFunction(naturalDerivatives);

shapeQ16(0.5, 0.5)
naturalDerivativesQ16(0.5, 0.5)
[shape, naturalDerivatives] = shapeFunctionQ9(0.5, 0.5)

function [shape, naturalDerivatives] = shapeFunctionQ16(xi, eta)

    shape = shapeQ16(xi, eta);

    naturalDerivatives = naturalDerivativesQ16(xi, eta);

end

function [shape, naturalDerivatives] = shapeFunctionQ9(xi, eta)

    shape = [
        (eta*xi*(eta - 1)*(xi - 1))/4, ...
        (eta*xi*(xi/2 + 1/2)*(eta - 1))/2, ...
        (eta*xi*(xi/2 + 1/2)*(eta + 1))/2, ...
        (eta*xi*(eta + 1)*(xi - 1))/4, ...
        -(eta*(eta - 1)*(xi - 1)*(xi + 1))/2, ...
        -xi*(xi/2 + 1/2)*(eta - 1)*(eta + 1), ...
        -(eta*(eta + 1)*(xi - 1)*(xi + 1))/2, ...
        -(xi*(eta - 1)*(eta + 1)*(xi - 1))/2, ...
        (eta - 1)*(eta + 1)*(xi - 1)*(xi + 1)
    ];

    naturalDerivatives = [
        (eta*xi*(eta - 1))/4 + (eta*(eta - 1)*(xi - 1))/4,...
        (eta*xi*(eta - 1))/4 + (eta*(xi/2 + 1/2)*(eta - 1))/2,...
        (eta*xi*(eta + 1))/4 + (eta*(xi/2 + 1/2)*(eta + 1))/2,...
        (eta*xi*(eta + 1))/4 + (eta*(eta + 1)*(xi - 1))/4,...
        -(eta*(eta - 1)*(xi - 1))/2 - (eta*(eta - 1)*(xi + 1))/2,...
        -(xi/2 + 1/2)*(eta - 1)*(eta + 1) - (xi*(eta - 1)*(eta + 1))/2,...
        -(eta*(eta + 1)*(xi - 1))/2 - (eta*(eta + 1)*(xi + 1))/2,...
        -(xi*(eta - 1)*(eta + 1))/2 - ((eta - 1)*(eta + 1)*(xi - 1))/2,...
        (eta - 1)*(eta + 1)*(xi - 1) + (eta - 1)*(eta + 1)*(xi + 1);

        (eta*xi*(xi - 1))/4 + (xi*(eta - 1)*(xi - 1))/4, ...
        (eta*xi*(xi/2 + 1/2))/2 + (xi*(xi/2 + 1/2)*(eta - 1))/2, ...
        (eta*xi*(xi/2 + 1/2))/2 + (xi*(xi/2 + 1/2)*(eta + 1))/2, ...
        (eta*xi*(xi - 1))/4 + (xi*(eta + 1)*(xi - 1))/4, ...
        -(eta*(xi - 1)*(xi + 1))/2 - ((eta - 1)*(xi - 1)*(xi + 1))/2, ...
        -xi*(xi/2 + 1/2)*(eta - 1) - xi*(xi/2 + 1/2)*(eta + 1), ...
        -(eta*(xi - 1)*(xi + 1))/2 - ((eta + 1)*(xi - 1)*(xi + 1))/2, ...
        -(xi*(eta - 1)*(xi - 1))/2 - (xi*(eta + 1)*(xi - 1))/2, ...
        (eta - 1)*(xi - 1)*(xi + 1) + (eta + 1)*(xi - 1)*(xi + 1)
    ];

end
