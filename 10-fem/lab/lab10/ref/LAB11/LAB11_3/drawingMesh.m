function drawingMesh(nodeCoordinates, elementNodes, type, format)
switch type
    case 'T3'
        seg1 = [1,2,3,1];
    case 'T6'
        seg1 = [1,4,2,5,3,6,1];
    case 'Q4'
        seg1 = [1,2,3,4,1];
    otherwise
		disp('Type is not supported yet')
end

for e = 1:length(elementNodes(:,1))
    plot(nodeCoordinates(elementNodes(e,seg1),1),nodeCoordinates(elementNodes(e,seg1),2),format)
    hold on
end

axis equal
hold off