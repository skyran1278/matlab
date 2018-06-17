clc; clear; close all;

vars = load('lab7.mat');

stiffness = formStiffness2D(vars.gDof, vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, vars.thickness);

displacements = solution(vars.gDof, vars.prescribedDof, stiffness, vars.force, vars.displacements);

outputDisplacements(displacements, vars.numberNodes, vars.gDof);

[stressGpCell, stressNodeCell] = stressRecovery(vars.numberElements, vars.elementNodes, vars.nodeCoordinates, vars.D, displacements);

outputStress(vars.elementNodes, vars.nodeCoordinates, stressGpCell, stressNodeCell);
