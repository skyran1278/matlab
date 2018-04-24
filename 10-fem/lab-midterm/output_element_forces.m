function [] = output_element_forces(E, A, L, number_elements, element_nodes, node_coordinates, displacements)


    syms xi;

    number_element_nodes = size(element_nodes, 2);

    ngp = fix(number_element_nodes / 2) + 1;

    gauss_quadrature = gauss_quadrature_curry(ngp);

    xc = linspace(-1, 1, number_element_nodes);

    Ne = lagrange_interpolation(xc, xi);

    diff_Ne = diff(Ne);

    Ke = sym(zeros(number_element_nodes, number_element_nodes));

    disp('Element Forces')
    fprintf('element node_I node_J    force I     force J\n')

    for e = 1 : number_elements

        elementDof = element_nodes(e, :);

        xe = node_coordinates(elementDof).';

        J = diff_Ne * xe;

        Be = 1 / J * diff_Ne;

        Ke(xi) = Be.' * E(e) * A(Ne * xe) * Be;

        k = J * gauss_quadrature(Ke, ngp);

        node_I = element_nodes(e, 1);

        node_J = element_nodes(e, end);

        force = simplify(k * displacements(element_nodes(e, :)));

        fprintf('%3d%6d%6d%15.4e%15.4e\n', e, node_I, node_J, force(1), force(end))
    end

end
