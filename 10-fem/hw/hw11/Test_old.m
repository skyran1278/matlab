% Hw11_1
clc;clear;close all;
syms xi eta

% cubic=3 order
order=3;

% shape
N4=L_fun(order,4,xi)*L_fun(order,1,eta);
N6=L_fun(order,4,xi)*L_fun(order,3,eta);
N16=L_fun(order,2,xi)*L_fun(order,3,eta);

% plot
plot_2D_shape(order,N4)
    

    
    

function L_shape= L_fun(up,sub,x)
        format rat
        xe=-1:2/up:1;
        
        M = xe(sub);

        % 回傳不等於 xi 的
        xj = xe(xe ~= M);

        % 連乘
        % 回傳 shape function
        L_shape = prod((x - xj) ./ (M - xj));

end

function plot_2D_shape(order,shape)
    x=-1:2/order:1;
    y=-1:2/order:1;
    
    Location=[];
    for i=length(x)
        for j=length(y)
            z=subs(shape,[xi,eta],[x(i),y(j)]);
            Location=[Location; [x(i), y(j), z]  ];
        end
    end
    
    
end