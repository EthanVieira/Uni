function [nc, dof] = readConstraints(fid)

% open the file
%fid = 'inputFile.txt';
inputFile = fopen(fid);

% Inputting first two values
numberOfNodes = fscanf(inputFile,'%f', [1 1]);
numberOfElements = fscanf(inputFile, '%f', [1 1]);

% skip coords, connec, and props
fscanf(inputFile, '%*f', [2 numberOfNodes]);
fscanf(inputFile, '%*f', [3 numberOfElements]);
fscanf(inputFile, '%*f', [3 1]);

% Retrieve the constraints
nc = fscanf(inputFile, '%f', [1 1]);
dof = fscanf(inputFile, '%f', [nc 1]);

% echo print

fprintf('The number of constraints is %d.\n', nc)
fprintf('The list of dof specified to be zero is %s.\n', mat2str(dof))

% close the file

fclose(inputFile);

end