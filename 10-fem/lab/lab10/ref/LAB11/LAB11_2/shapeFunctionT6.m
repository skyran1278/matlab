% .............................................................     
    function [shape,naturalDerivatives]=shapeFunctionT6(xi2,xi3)

    % shape function and derivatives for T6 elements
    % shape : Shape functions
    % naturalDerivatives: derivatives w.r.t. xi and eta 
    % xi, eta: natural coordinates (-1 ... +1)
    xi1 = 1 - xi2 -xi3;
    shape=[ xi1*(2*xi1-1), xi2*(2*xi2-1), xi3*(2*xi3-1)...
            4*xi1*xi2, 4*xi2*xi3, 4*xi3*xi1];
    naturalDerivatives=...
          [4*xi2 + 4*xi3 - 3, 4*xi2 - 1,         0, 4 - 4*xi3 - 8*xi2, 4*xi3,            -4*xi3; 
           4*xi2 + 4*xi3 - 3,         0, 4*xi3 - 1,            -4*xi2, 4*xi2, 4 - 8*xi3 - 4*xi2];

    end % end function shapeFunctionQ4
  
