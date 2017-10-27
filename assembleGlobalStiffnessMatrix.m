function [unglobalK] = assembleGlobalStiffnessMatrix(DOF, numberOfElements, elementStiffness, assemblyVector)          


unglobalK = zeros(numel(DOF),numel(DOF));

for i = 1:numberOfElements
    for j = 1:length(assemblyVector(i,:))
        for k = 1:length(assemblyVector(i,:))
            unglobalK(assemblyVector(i,j), assemblyVector(i,k)) = unglobalK(assemblyVector(i,j), assemblyVector(i,k)) + elementStiffness(j,k);
        end
    end

end
disp('The unconstrained global stiffness matrix is')
unglobalK

end