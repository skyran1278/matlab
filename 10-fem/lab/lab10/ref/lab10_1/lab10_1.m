% 1D Clamped Bar with a Point Load
% Isoparametric Formulation Implementation
% clear memory
clear all
clc
close all

% E: modulus of elasticity
% A: area of cross section
% L: length of bar
E = 1e4; A = 1; l = 1; L = 2*l; c = 1;
% n: number of section
n=[1 2 4 8];
for type = 1:2 %linear:1 quadratic:2
    for i = 1:length(n)
        % numberElements: number of elements
        numberElements = n(i);
        switch type
            case 1
                % numberNodes: number of nodes
                numberNodes = numberElements + 1;
                % generation of coordinates and connectivities
                elementNodes=zeros(numberElements,2);
                node = 1:numberNodes;
                for j = 1:numberElements;
                    elementNodes(j,:)=[node(j) node(j+1)];
                end
        end
        switch type
            case 2
                % numberNodes: number of nodes
                numberNodes = 2*numberElements + 1;
                % generation of coordinates and connectivities
                elementNodes=zeros(numberElements,3);
                node = 1:numberNodes;
                for j = 1:numberElements;
                    elementNodes(j,:)=[node(2*j-1) node(2*j) node(2*j+1)];
                end
        end
        nodeCoordinates=linspace(0,L,numberNodes);
        Le = ones(1,n(i))*L/numberElements;
        h(type,i) = L/numberElements;
        % for structure:
        % displacements: displacement vector
        % force : force vector
        % stiffness: stiffness matrix
        force=zeros(numberNodes,1);
        stiffness=zeros(numberNodes,numberNodes);
        % applied load at node 2
        force(end)=-c*l^2/A;

        % computation of the system stiffness matrix
        for e=1:numberElements;
            % elementDof: element degrees of freedom (Dof)
            elementDof=elementNodes(e,:) ;
            detJacobian=Le(e)/2;
            invJacobian=1/detJacobian;
            switch type
                case 1
                    ngp = 2;
                case 2
                    ngp = 3;
            end
            [w,xi]=gauss1d(ngp);
            xc = 0.5*(nodeCoordinates(elementDof(1))+nodeCoordinates(elementDof(end)));
            for ip=1:ngp;
                switch type
                    case 1
                        [shape,naturalDerivatives]=shapeFunctionL2(xi(ip));
                    case 2
                        [shape,naturalDerivatives]=shapeFunctionL3(xi(ip));
                end
                B=naturalDerivatives*invJacobian;
                stiffness(elementDof,elementDof)=...
                    stiffness(elementDof,elementDof)+ B'*B*w(ip)*detJacobian*E*A;
                force(elementDof) = force(elementDof)+...
                    c*(xc+detJacobian*xi(ip))*shape'*detJacobian*w(ip);
            end
        end
        % boundary conditions and solution
        % prescribed dofs
        prescribedDof=[1];
        % solution
        GDof=numberNodes;
        displacements=zeros(1,numberNodes)';
        displacements=solution(displacements,GDof,prescribedDof,stiffness,force);
        % output displacements/reactions
        % outputDisplacementsReactions(displacements,stiffness, ...
            % numberNodes,prescribedDof,force);

        % exact solution
        u_exact = @(x) c/(A*E)*(-x.^3/6 + l^2*x);
        s_exact = @(x) c/(A*E)*(-x.^2/2 + l^2);

        % compute error in a finite element solution
        displacementsError = 0;
        stressError = 0;
        for e=1:numberElements;
            % elementDof: element degrees of freedom (Dof)
            elementDof=elementNodes(e,:);
            detJacobian=Le(e)/2;
            invJacobian=1/detJacobian;
            ngp = 4;
            [w,xi]=gauss1d(ngp);
            xc = 0.5*(nodeCoordinates(elementDof(1))+nodeCoordinates(elementDof(end)));
            for ip=1:ngp;
                switch type
                    case 1
                        [shape,naturalDerivatives]=shapeFunctionL2(xi(ip));
                    case 2
                        [shape,naturalDerivatives]=shapeFunctionL3(xi(ip));
                end
                B=naturalDerivatives*invJacobian;
                displacementsError = displacementsError + (u_exact(xc+detJacobian*xi(ip))-shape*displacements(elementDof,1))^2*detJacobian*w(ip);
                stressError = stressError + (s_exact(xc+detJacobian*xi(ip))-B*displacements(elementDof,1))^2*detJacobian*w(ip);
            end
        end
        eL2_norm(type,i) = sqrt(displacementsError);
        een_norm(type,i) = sqrt(stressError);
    end
 %convergent rate
 L2(type,:)=(log10(eL2_norm(type,end))-log10(eL2_norm(type,1)))/(log10(h(type,end))-log10(h(type,1)));
 En(type,:)=(log10(een_norm(type,end))-log10(een_norm(type,1)))/(log10(h(type,end))-log10(h(type,1)));
end

%print
% fprintf('Linear elements\n')
% fprintf('<strong>________________________________________________________________________</strong>\n')
% fprintf('<strong> h             log10h              ||e||L2             log10||e||L2           ||e||en              log||e||en</strong>\n')
% fprintf('<strong>________________________________________________________________________</strong>\n')
%  for i = 1:length(h(1,:))
%     fprintf('%2.2f     %-4.4f     %10.4e     %-6.4f     %10.4e     %-6.4f\n',h(1,i),log10(h(1,i)),eL2_norm(1,i),log10(eL2_norm(1,i)),een_norm(1,i),log10(een_norm(1,i)))
%     fprintf('________________________________________________________________________\n')
%  end
% fprintf('<strong>________________________________________________________________________</strong>\n')
% fprintf('Quadratic elements\n')
% fprintf('<strong>________________________________________________________________________</strong>\n')
% fprintf('<strong> h             log10h              ||e||L2             log10||e||L2           ||e||en              log||e||en</strong>\n')
% fprintf('<strong>________________________________________________________________________</strong>\n')
%  for i = 1:length(h(1,:))
%     fprintf('%2.2f     %-4.4f     %10.4e     %-6.4f     %10.4e     %-6.4f\n',h(2,i),log10(h(2,i)),eL2_norm(2,i),log10(eL2_norm(2,i)),een_norm(2,i),log10(een_norm(2,i)))
%     fprintf('________________________________________________________________________\n')
%  end

% fprintf('=============================================================================\n')
% fprintf('Convergence rate | Linear L2   | Quadratic L2  | Linear En   | Quadratic En |\n')
% fprintf('=========================================================================\n')
% fprintf('                 |%10.4e   | %10.4e    | %10.4e  | %10.4e   |\n',L2(1,1),L2(2,1),En(1,1),En(2,1))
% fprintf('=============================================================================\n')

%plot
semilogy(log10(h(1,:)),eL2_norm(1,:),'r-*',log10(h(2,:)),eL2_norm(2,:),'b-*',log10(h(1,:)),een_norm(1,:),'r--o',log10(h(2,:)),een_norm(2,:),'b--o');
xlabel('log_{10}h');
legend('L_{2} Linear','L_{2} Quadratic','en Linear','en Quadratic','Location','SouthEast' );
axis([-0.603 0.301 1e-8 1e-4])
