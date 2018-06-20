function [shape_LN, naturalDerivatives_LN] = shapeFunction_LN(N)

% shape function and derivatives for LN elements , N = 2,3,4...
% shape_LN : Shape functions
% naturalDerivativesLN: derivatives w.r.t. xi
% xi: natural coordinates (-1 ... +1)

syms xi

nodeCoordinates = linspace(-1,1,N);
p = ones(N,N-1);
shape_LN = ones(N,1)*xi/xi;

for i = 1:N
    p(i,:)=setdiff(nodeCoordinates,nodeCoordinates(i));
    for j=1:N-1
        shape_LN(i)= shape_LN(i)*(xi-p(i,j))/(nodeCoordinates(i)-p(i,j));
    end
end

naturalDerivatives_LN = diff(shape_LN,xi);

end
