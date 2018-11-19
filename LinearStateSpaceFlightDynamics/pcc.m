function rjz = pcc(z, zeta)

%{
This function calculates the Partial Correlation Coefficients,
rjz, for inputs z (a Nx13 array), the selected output 
data, zeta (a Nx13 array, the regressors (states and controls 
data), and n, the current number of parameters in the model.
The output is a 1x13 array of the correlation coefficients 
for the given inputs z. 
%}


% Compue zbar
zbar = mean(z);

% Compute zetabar (13x1 vector)
for j = 1:13
    zeta_bar(j) = mean(zeta(:,j));
end

% Compute SZZ
for i = 1:length(z)
    szz(i) = (z(i)-zbar)^2;
end
SZZ = sum(szz);

% Compute Sjj and Sjz (13x1 vector)
for j = 1:13
    for i = 1:length(zeta(:,1))
        sjj(i) = (zeta(i,j)-zeta_bar(j))^2;
        sjz(i) = (zeta(i,j)-zeta_bar(j))*(z(i)-zbar);
    end
    Sjj(j) = sum(sjj);
    Sjz(j) = sum(sjz);
end

% Compute rjz (13x1 vector)
for j = 1:(length(zeta(1,:))-1)
    rjz(j) = Sjz(j)^2/(Sjj(j)*SZZ);
end

return