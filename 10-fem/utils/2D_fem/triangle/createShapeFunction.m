function f = createShapeFunction(numNodePerElement, schemes)
%
% shape function and derivatives.
%
% @since 2.1.0
% @param {number} [numNodePerElement] 一個 element 有幾個 nodes.
% @param {string} [schemes] corner first or along boundary.
% @return {function} [shapeFunction] for T6.
%
% @param {number} [xi2]
% @param {number} [xi3]
% @param {array} [shape] Shape functions.
% @return {array} [naturalDerivatives] derivatives w.r.t. xi2 and xi3.
%

    switch numNodePerElement

        case 6
            f = @shapeFunctionT6;

    end

    function [shape, naturalDerivatives] = shapeFunctionT6(xi2, xi3)

        xi1 = 1 - xi2 -xi3;

        shape = [ xi1*(2*xi1-1), xi2*(2*xi2-1), xi3*(2*xi3-1), 4*xi1*xi2, 4*xi2*xi3, 4*xi3*xi1];

        naturalDerivatives = [
            4*xi2 + 4*xi3 - 3, 4*xi2 - 1,         0, 4 - 4*xi3 - 8*xi2, 4*xi3,            -4*xi3;
            4*xi2 + 4*xi3 - 3,         0, 4*xi3 - 1,            -4*xi2, 4*xi2, 4 - 8*xi3 - 4*xi2;
        ];

    end

end
