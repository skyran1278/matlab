% ............................................................. 

    function [weights,locations]=gauss2d(option)
    % Gauss quadrature in 2D
    % option '2x2'
    % option '1x1' 
    % locations: Gauss point locations
    % weights: Gauss point weights
        
    switch option
        case '1'
    
        locations=...
          [ 1/3 1/3 1/3 ];
        weights=[1/2]; 
    
        case '3'
        
        locations=[1/2 1/2 0;
                   0 1/2 1/2;
                   1/2 0 1/2];
        weights=[1/6;1/6;1/6];
    end

    end  % end function gauss2d
    