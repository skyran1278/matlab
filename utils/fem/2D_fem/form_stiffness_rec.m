function stiffness = form_stiffness_rec(G_dof, number_elements, element_nodes, node_coordinates, D, thickness)
%
% compute stiffness matrix.
% for plane stress rectangular elements.
%
% @since 1.0.0
% @param {number} [G_dof] global number of degrees of freedom.
% @param {number} [number_elements] number of elements.
% @param {array} [element_nodes] 每個元素有幾個節點，還有他們的分佈.
% @param {array} [node_coordinates] 節點位置.
% @param {array} [D] 2D matrix D.
% @param {number} [thickness] 厚度.
% @return {array} [stiffness] stiffness.
%

    stiffness = zeros(G_dof);

    % 一個 element 有幾個 nodes
    num_node_per_element = size(element_nodes, 2);

    % 一個 element 有幾個自由度
    num_e_dof = 2 * num_node_per_element;
    element_dof = zeros(1, num_e_dof);

    [gauss_weights, gauss_locations] = gauss2d('2x2');

    for e = 1 : number_elements

        for index = 1 : num_node_per_element
            % x
            element_dof(2 * index - 1) = 2 * element_nodes(e, index) - 1;
            % y
            element_dof(2 * index) = 2 * element_nodes(e, index);
        end

        %
        % THIS IS A HACK: we assume node 1 and node 2 align
        % with x-axis and node 2 and node3 align with y-axis
        %
        a = 0.5 * abs(nodeCoordinates(elementNodes(e, 2), 1) - nodeCoordinates(elementNodes(e, 1), 1));
        b = 0.5 * abs(nodeCoordinates(elementNodes(e, 3), 2) - nodeCoordinates(elementNodes(e, 2), 2));

        % cycle for Gauss point
        for q=1:size(gaussWeights,1)
            GaussPoint=gaussLocations(q,:);
            xi=GaussPoint(1);
            eta=GaussPoint(2);

            % shape functions and derivatives
            [shapeFunction,naturalDerivatives]=shapeFunctionQ4(xi,eta);
            XYderivatives(1,:) = 1/a * naturalDerivatives(1,:);
            XYderivatives(2,:) = 1/b * naturalDerivatives(2,:);

            % B matrix
            B=zeros(3,numEDOF);
            B(1,1:2:numEDOF) = XYderivatives(1,:);
            B(2,2:2:numEDOF) = XYderivatives(2,:);
            B(3,1:2:numEDOF) = XYderivatives(2,:);
            B(3,2:2:numEDOF) = XYderivatives(1,:);

            % stiffness matrix
            stiffness(elementDof,elementDof)=...
            stiffness(elementDof,elementDof)+...
            thickness*a*b*B'*D*B*gaussWeights(q);
        end

        % B matrix
        x1 = node_coordinates(element_nodes(e, 1), 1);
        y1 = node_coordinates(element_nodes(e, 1), 2);
        x2 = node_coordinates(element_nodes(e, 2), 1);
        y2 = node_coordinates(element_nodes(e, 2), 2);
        x3 = node_coordinates(element_nodes(e, 3), 1);
        y3 = node_coordinates(element_nodes(e, 3), 2);

        A = 1 / 2 * det([1 x1 y1; 1 x2 y2; 1 x3 y3]);
        B = 1 / (2 * A) .* [y2 - y3, 0, y3 - y1, 0 y1 - y2, 0; 0, x3 - x2, 0, x1 - x3, 0, x2 - x1; x3 - x2, y2 - y3, x1 - x3, y3 - y1, x2 - x1, y1 - y2];

        k = A * thickness * B.' * D * B;

        if det(k) ~= 0
            warning('det(k) <> 0: element %d\n', e);
        end

        % stiffness matrix
        stiffness(element_dof, element_dof) = stiffness(element_dof, element_dof) + k;

    end

end

function [weights,locations]=gauss2d(option)
    % Gauss quadrature in 2D
    % option '2x2'
    % option '1x1'
    % locations: Gauss point locations
    % weights: Gauss point weights

    switch option
        case '2x2'

        locations=...
        [ -0.577350269189626 -0.577350269189626;
        0.577350269189626 -0.577350269189626;
        0.577350269189626 0.577350269189626;
        -0.577350269189626 0.577350269189626];
        weights=[ 1;1;1;1];

    case '1x1'

    locations=[0 0];
    weights=[4];
    end
 end % end function gauss2d

 function [shape,naturalDerivatives]=shapeFunctionQ4(xi,eta)
    % shape function and derivatives for Q4 elements
    % shape : Shape functions
    % naturalDerivatives: derivatives w.r.t. xi and eta
    % xi, eta: natural coordinates (-1 ... +1)

    shape=1/4*[ (1-xi)*(1-eta), (1+xi)*(1-eta), ...
    (1+xi)*(1+eta), (1-xi)*(1+eta)];
    naturalDerivatives=...
    1/4*[-(1-eta), 1-eta, 1+eta, -(1+eta);
    -(1-xi), -(1+xi), 1+xi, 1-xi];
    end % end function shapeFunctionQ4
