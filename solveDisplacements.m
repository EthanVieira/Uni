function [q] = solveDisplacements(DOF, globalK, dl, np)

% load vector

loads = zeros(numel(DOF),1);

for i = 1:np
    loads(dl(i,1)) = dl(i,2);
end

format long
disp('Nodal Displacements')
warning off; % annoying matrix error caused by penalty method

% solve 

q = globalK\loads

end