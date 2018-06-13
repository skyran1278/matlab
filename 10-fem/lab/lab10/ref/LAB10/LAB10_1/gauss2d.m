% ............................................................. 

    function [weights,locations]=gauss2d(option)
    % Gauss quadrature in 2D
    % option '2x2'
    % option '1x1' 
    % locations: Gauss point locations
    % weights: Gauss point weights
        
    switch option
        case '4x4'
            loc = [-0.861136311594052, -0.339981043584856,...
                0.339981043584856, 0.861136311594052];
            w = [0.347854845137454, 0.652145154862546,...
                0.652145154862546, 0.347854845137454];
            locations = [loc(1),loc(1);loc(4),loc(1);
                         loc(4),loc(4);loc(1),loc(4);
                         loc(2),loc(1);loc(3),loc(1);
                         loc(4),loc(2);loc(4),loc(3);
                         loc(3),loc(4);loc(2),loc(4);
                         loc(1),loc(3);loc(1),loc(2);
                         loc(2),loc(2);loc(3),loc(2);
                         loc(3),loc(3);loc(2),loc(3)];
            weights = [w(1)*w(1);w(4)*w(1);
                       w(4)*w(4);w(1)*w(4);
                       w(2)*w(1);w(3)*w(1);
                       w(4)*w(2);w(4)*w(3);
                       w(3)*w(4);w(2)*w(4);
                       w(1)*w(3);w(1)*w(2);
                       w(2)*w(2);w(3)*w(2);
                       w(3)*w(3);w(2)*w(3)];
        
        case '3x3'
    
        locations = [-1 -1;1 -1;1  1;-1  1;
                    0 -1;1  0;0  1;-1  0;0  0;]*sqrt(3/5);
        w = [0.5555555556,     0.8888888889,  0.5555555556];
        weights = [w(1)*w(1);w(3)*w(1);w(3)*w(3);w(1)*w(3);
                   w(2)*w(1);w(3)*w(2);w(2)*w(3);w(1)*w(2);w(2)*w(2)];
        
        case '2x2'
    
        locations=...
          [ -0.577350269189626 -0.577350269189626;
             0.577350269189626 -0.577350269189626;
             0.577350269189626  0.577350269189626;
            -0.577350269189626  0.577350269189626];
        weights=[ 1;1;1;1]; 
    
        case '1x1'
        
        locations=[0 0];
        weights=[4];
    end

    end  % end function gauss2d