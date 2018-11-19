function fjz = pfr(X, z, thetaz)

%{
This function calculates the Partial F-Ratio, Fjz for inputs X (Nx13),
the selected regressor matrix, z (1x13), the output data, and thetaz_hat
(1x13), the model parameters. The output is a 1x13 array of partial
F-Ratios, one for each of the possible regressors.
%}

% Calculate D
D = misvd(X.'*X);

% Calculate sigma squared hat
temp = X*thetaz;
for i = 1:length(z)
    sigsq(i) = (z(i)-temp(i))^2/(length(z)-length(thetaz));
end
sigsqhat = sum(sigsq);

% Calculate s^2(thetaz hat) and Fjz
for j = 1:length(thetaz)
    sstheta(j) = sigsqhat*D(j,j);
    fjz(j) = thetaz(j)^2/sstheta(j);
end

return
