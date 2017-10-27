function [xc, Ym, h, w] = readProperties(fid)

% open the file
%fid = 'inputFile.txt'
inputFile = fopen(fid);

% Inputting first two values
numberOfNodes = fscanf(inputFile,'%f', [1 1]);
numberOfElements = fscanf(inputFile, '%f', [1 1]);

% Retrieve node x coordinates
xc = fscanf(inputFile, '%f', [2 numberOfNodes]);
xc = xc.';

% skip connectivity
fscanf(inputFile, '%*f', [3 numberOfElements]);

% Retrieve the rest of properties
Ym = fscanf(inputFile, '%f', [1 1]);
h = fscanf(inputFile, '%f', [1 1]);
w = fscanf(inputFile, '%f', [1 1]);

% echo print
for i=1:numberOfNodes
    fprintf('The node number %d has an x-coordinate of %d.\n', xc(i,:))
end
fprintf('The Young''s modulus is %f psi.\n', Ym)
fprintf('The height is %f in.\n', h)
fprintf('The width is %f in.\n', w)

% close the file

fclose(inputFile);

end