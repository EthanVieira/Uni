clear; clc; close all

delete 'outputFile.txt';
diary('outputFile.txt');

fid = 'inputFile.txt'

[numberOfNodes,numberOfElements,connectivity] = readMesh(fid);
[xc, Ym, h, w] = readProperties(fid);
[nc, dof] = readConstraints(fid);
[np, dl] = readLoads(fid);
[DOF, assemblyVector] = getElementDOF(connectivity, numberOfNodes, numberOfElements);
[elementStiffness] = getElementK(numberOfElements, Ym, w, h, xc);
[unglobalK] = assembleGlobalStiffnessMatrix(DOF, numberOfElements, elementStiffness, assemblyVector); 
[globalK] = imposeConstraints(unglobalK, dof);
[q] = solveDisplacements(DOF, globalK, dl, np);




diary off

