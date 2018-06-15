clc; clear; close all;

cornerCoordinates = [0 0; 60 0; 0 20; 60 20;];
xMesh = 6;
yMesh = 2;
[numberElements, numberNodes, elementNodes, nodeCoordinates, nodes, flipNodes] = meshQ4(cornerCoordinates, xMesh, yMesh);

save('meshQ4TestLab7.mat');

a = load('meshQ4TestLab7.mat');
