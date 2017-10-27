function [numberOfNodes,numberOfElements,connectivity] = readMesh(fid)

% open the file
%fid = 'inputFile.txt'
inputFile = fopen(fid);

% skip the first value and input number of elements
numberOfNodes = fscanf(inputFile,'%f', [1 1]);
numberOfElements = fscanf(inputFile, '%f', [1 1]);

% skip to element connectivity using numberOfNodes
fscanf(inputFile, '%*f', [numberOfNodes 2]);

% input element connectivity
connectivity = fscanf(inputFile, '%f', [3 numberOfElements]);
% transpose to make up for my inability to learn how to alter the scan
% order
connectivity = connectivity.';
connectivity(:,1) = [];

%echo print
fprintf('The number of nodes is %i and the number of elements is %i.\n', numberOfNodes, numberOfElements)
for i=1:numberOfElements
    fprintf('For element %i, the connectivity is %d, %d.\n', i, connectivity(i,:))   
end

% close the file

fclose(inputFile);

end