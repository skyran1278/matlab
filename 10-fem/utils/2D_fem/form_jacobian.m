function [jacobian_matrix, jacobian_inv, diff_shape_XY] = form_jacobian(node_coordinates, diff_shape)
%
% cal jacobian.
%
% @since 1.0.1
% @param {type} [node_coordinates] nodal coordinates at element level.
% @param {type} [diff_shape] derivatives w.r.t. xi and eta.
% @return {type} [jacobian_matrix] Jacobian matrix.
% @return {type} [jacobian_inv] inverse of Jacobian Matrix.
% @return {type} [diff_shape_XY] derivatives w.r.t. x and y
% @see dependencies
%

    jacobian_matrix = diff_shape * node_coordinates;

    jacobian_inv = inv(jacobian_matrix);

    % TODO: check which one is fast
    diff_shape_XY = jacobian_matrix \ diff_shape;
    % diff_shape_XY = jacobian_inv * diff_shape;

end
