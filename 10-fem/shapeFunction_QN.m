function [shape_QN, naturalDerivatives_QN] = shapeFunction_QN(N)
% shape function and derivatives for Lagrange-Series QN elements , N = 4,9,16...
% shape_QN : Shape functions
% naturalDerivatives_QN : derivatives w.r.t. xi & eta
% xi: natural coordinates (-1 ... +1)
% eta: natural coordinates (-1 ... +1)
%% Point numbers for example:
%   N = 2;  3 4 
%           1 2
%
%   N = 3;  7 8 9
%           4 5 6
%           1 2 3
%
%   N = 4; 13 14 15 16
%           9 10 11 12
%           5  6  7  8
%           1  2  3  4
%%  Code

nodeCoordinate = linspace(-1,1,sqrt(N));
ne = linspace(1,N,N);
ne = vec2mat(ne,sqrt(N));

syms xi
n = length(nodeCoordinate);
p = ones(n,n-1);
shape_xi = ones(n,1)*xi/xi;
for i = 1:n
    p(i,:) = setdiff(nodeCoordinate,nodeCoordinate(i));
    for j = 1:n-1
        shape_xi(i) = shape_xi(i)*(xi-p(i,j))/(nodeCoordinate(i)-p(i,j));
    end
end

syms eta
n = length(nodeCoordinate);
p = ones(n,n-1);
shape_eta = ones(n,1)*eta/eta;
for i = 1:n
    p(i,:) = setdiff(nodeCoordinate,nodeCoordinate(i));
    for j = 1:n-1
        shape_eta(i) = shape_eta(i)*(eta-p(i,j))/(nodeCoordinate(i)-p(i,j));
    end
end

shape_QN = ones(N,1)*(xi/xi)*(eta/eta);
for i = 1:sqrt(N)
    for j = 1:sqrt(N)
        shape_QN(ne(i,j)) = shape_xi(j)*shape_eta(i);
    end
end

naturalDerivatives_QN = [diff(shape_QN,xi);diff(shape_QN,eta)];

end