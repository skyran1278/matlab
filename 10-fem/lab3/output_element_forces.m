function [] = output_element_forces(E, A, L, numberElements, elementNodes, displacements)

    disp('Element Forces')
    fprintf('element node_I node_J    force I     force J\n')

    for e = 1 : numberElements
        k = E(e) * A / L(e) * [1 -1; -1 1];
        node_I = elementNodes(e, 1);
        node_J = elementNodes(e, 2);
        force = k * displacements(elementNodes(e, :));
        fprintf('%3d%6d%6d%15.4e%15.4e\n', e, node_I, node_J, force(1), force(2))
    end

end
