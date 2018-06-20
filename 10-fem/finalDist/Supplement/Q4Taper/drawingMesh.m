function drawingMesh(nodeCoordinates,elementNodes,type,format,color,alpha,data)
if nargin < 6
    alpha = 1;
end
switch type
    case 'T3'
        seg = [1,2,3,1];
        for e = 1:length(elementNodes(:,1))
            plot(nodeCoordinates(elementNodes(e,seg),1),nodeCoordinates(elementNodes(e,seg),2),format)
            hold on
        end
        axis equal
        hold off
    case 'Q4'
        seg = [1,2,3,4,1];
        for e = 1:length(elementNodes(:,1))
            plot(nodeCoordinates(elementNodes(e,seg),1),nodeCoordinates(elementNodes(e,seg),2),format)
            hold on
        end
        axis equal
        hold off
    case 'Q4F'
        seg = [1,2,3,4,1];
        for e = 1:size(elementNodes,1)
            nodes = elementNodes(e,seg);
            patch('Vertices',nodeCoordinates(nodes,:)...
                ,'Faces',1:4,'FaceColor',color...
                ,'BackFaceLighting','reverselit'...
                ,'FaceAlpha',alpha);
            hold on
        end
        axis equal
        hold off
    case 'Q4S'
        seg = [1,2,3,4,1];
        for e = 1:size(elementNodes,1)
            nodes = elementNodes(e,seg);
            patch('Vertices',nodeCoordinates(nodes,:)...
                ,'FaceVertexCData',data(nodes)...
                ,'Faces',1:4 ...
                ,'FaceColor','interp'...
                ,'BackFaceLighting','reverselit'...
                ,'FaceAlpha',alpha);
            hold on
        end
        axis equal
        hold off
        colorbar
    case 'Q8'
        seg = [1,5,2,6,3,7,4,8];
        for e = 1:length(elementNodes(:,1))
            plot(nodeCoordinates(elementNodes(e,seg),1),nodeCoordinates(elementNodes(e,seg),2),format)
            hold on
        end
        axis equal
        hold off
    case 'Q12'
        seg = [1,5,6,2,7,8,3,9,10,4,11,12];
        for e = 1:length(elementNodes(:,1))
            plot(nodeCoordinates(elementNodes(e,seg),1),nodeCoordinates(elementNodes(e,seg),2),format)
            hold on
        end
        axis equal
        hold off
    case 'C3D8'
        edges = [1,2;2,3;3,4;4,1;5,6;6,7;7,8;8,5;1,5;2,6;3,7;4,8];
        for e = 1:length(elementNodes(:,1))
            for s = 1:12
            plot3(nodeCoordinates(elementNodes(e,edges(s,:)),1)...
                 ,nodeCoordinates(elementNodes(e,edges(s,:)),2)...
                 ,nodeCoordinates(elementNodes(e,edges(s,:)),3)...
                 ,format,'Color',color)
            hold on
            end
        end
        axis equal
        hold off
        view(30,30);
    case 'C3D8F'
        faces = [4,3,2,1;5,6,7,8;1,2,6,5;2,3,7,6;3,4,8,7;5,8,4,1];
        for e = 1:size(elementNodes,1)
            for i = 1:6
                nodes = elementNodes(e,faces(i,:));
                patch('Vertices',nodeCoordinates(nodes,:)...
                    ,'Faces',1:4,'FaceColor',color...
                    ,'BackFaceLighting','reverselit'...
                    ,'FaceAlpha',alpha);
                hold on
            end
        end
        camproj('perspective')
        axis equal
        hold off
        view(30,30);
    case 'C3D8S'
        faces = [4,3,2,1;5,6,7,8;1,2,6,5;2,3,7,6;3,4,8,7;5,8,4,1];
        for e = 1:size(elementNodes,1)
            for i = 1:6
                nodes = elementNodes(e,faces(i,:));
                patch('Vertices',nodeCoordinates(nodes,:)...
                    ,'FaceVertexCData',data(nodes)...
                    ,'Faces',1:4 ...
                    ,'FaceColor','interp'...
                    ,'BackFaceLighting','reverselit'...
                    ,'FaceAlpha',alpha);
                hold on
            end
        end
        camproj('perspective')
        axis equal
        hold off
        view(30,30);
        colorbar
    case 'C3D8Abq'
        coor = [-nodeCoordinates(:,1),nodeCoordinates(:,[3,2])];
        HueyDrawingMesh(coor,elementNodes,'C3D8',format,color,alpha)
    case 'C3D8FAbq'
        coor = [-nodeCoordinates(:,1),nodeCoordinates(:,[3,2])];
        HueyDrawingMesh(coor,elementNodes,'C3D8F',format,color,alpha)
    case 'C3D8SAbq'
        coor = [-nodeCoordinates(:,1),nodeCoordinates(:,[3,2])];
        HueyDrawingMesh(coor,elementNodes,'C3D8S',format,color,alpha,data)
    otherwise
        for e = 1:length(elementNodes(:,1))
            plot(nodeCoordinates(elementNodes(e,:),1),nodeCoordinates(elementNodes(e,:),2),format)
            hold on
        end
        axis equal
        hold off
end