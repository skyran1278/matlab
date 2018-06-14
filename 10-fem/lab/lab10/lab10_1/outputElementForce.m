function outputElementForce...
    (numberElements,elementNodes,displacements,E,A,L)
fprintf('Elemnet    Forces\n')
fprintf('elemnet      node_I    node_J        force I        force  J\n')
for ii=1:numberElements
    k=E*A/L(ii);
    ff=k*[1 -1;-1 1]*[displacements(elementNodes(ii,1));displacements(elementNodes(ii,2))];
 fprintf( '%4.0f    %8.0f  %8.0f       %12.4e    %12.4e  \n',ii,elementNodes(ii,1),elementNodes(ii,2),ff(1),ff(2));
end
end
