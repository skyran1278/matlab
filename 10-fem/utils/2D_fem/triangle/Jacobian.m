function [JacobianMatrix, invJacobian, XYDerivatives] = Jacobian(nodeCoordinates, naturalDerivatives)
%
% cal jacobian.
%
% @since 2.0.1
% @param {type} [nodeCoordinates] nodal coordinates at element level.
% @param {type} [naturalDerivatives] derivatives w.r.t. xi and eta.
% @return {type} [JacobianMatrix] Jacobian matrix.
% @return {type} [invJacobian] inverse of Jacobian Matrix.
% @return {type} [XYDerivatives] derivatives w.r.t. x and y
% @see dependencies
%

    JacobianMatrix = naturalDerivatives * nodeCoordinates;

    invJacobian = inv(JacobianMatrix);

    % TODO: check which one is fast
    XYDerivatives = JacobianMatrix \ naturalDerivatives;
    % XYDerivatives = invJacobian * naturalDerivatives;

end
