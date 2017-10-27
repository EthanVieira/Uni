function [DOF, assemblyVector] = getElementDOF(connectivity, numberOfNodes, numberOfElements)


% Unconstrained DOFs
nDOF = 1;
for i = 1:numberOfNodes
    DOF(i,:) = [nDOF nDOF+1];
    nDOF = nDOF + 2;
end

for i = 1:numberOfElements
            assemblyVector(i,1) = DOF(connectivity(i,1),1);
            assemblyVector(i,2) = DOF(connectivity(i,1),2);
            assemblyVector(i,3) = DOF(connectivity(i,2),1);
            assemblyVector(i,4) = DOF(connectivity(i,2),2);   
            
           fprintf('The assembly vector for element %i is %d %d %d %d\n',i, assemblyVector(i,:))
end

end