clc
%------------------
% load data
%------------------
load elcentro
tt = earthquake(:,1);
acc = earthquake(:,2)/386.088583*9.81;
%==
tt_acc = [tt,acc];

%------------------
% save data
%------------------
save ELC_input tt_acc