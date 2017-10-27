function [np, dl] = readLoads(fid)

% open the file
%fid = 'inputFile.txt';
inputFile = fopen(fid);

% Inputting first two values
numberOfNodes = fscanf(inputFile,'%f', [1 1]);
numberOfElements = fscanf(inputFile, '%f', [1 1]);

% skip coords, connec, props, and constraints
fscanf(inputFile, '%*f', [2 numberOfNodes]);
fscanf(inputFile, '%*f', [3 numberOfElements]);
fscanf(inputFile, '%*f', [3 1]);
nc = fscanf(inputFile, '%f', [1 1]);
fscanf(inputFile, '%*f', [nc 1]);

% Retrieve the loads
np = fscanf(inputFile, '%f', [1 1]);
dl = fscanf(inputFile, '%f', [np 2]);

% echo print

fprintf('The number of point loads is %d.\n', np)
for i = 1:np
    fprintf('The dof and magnitude for each load is %d and %f (not sure what the units are).\n', dl(i,:))
end

% close the file

fclose(inputFile);

end