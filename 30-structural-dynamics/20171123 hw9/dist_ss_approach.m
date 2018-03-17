function [x,y] = dist_ss_approach(m,c,k,pc,dt,x)

%------------------
% Calculate continuous ABCD
%------------------
Ac = [0 1;-k/m -c/m];
Bc = [0;1/m];
Cc = [eye(2);[-k/m -c/m]];
Dc = [0;0;1/m];

%------------------
% Convert them into discrete ABCD
%------------------
Ad = expm(Ac*dt);
Bd = inv(Ac)*(Ad-eye(size(Ac,2)))*Bc;
Cd = Cc;
Dd = Dc;

%------------------
% Calculate response
%------------------
x = Ad*x + Bd*pc;
y = Cd*x + Dd*pc;