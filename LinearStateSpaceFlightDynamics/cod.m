function rz2 = cod(X, z, thetaz)

%{
This function calculates the Coefficient of Determination, Rz^2 for
inputs X (Nx13),the selected regressor matrix, z (1x13),  
the output data, and thetaz_hat (1x13), the model parameters.
The output is a single percentage value for each of the modeled outputs.
%}

numer = thetaz.'*X.'*z-length(z)*mean(z)^2;
denom = z'*z-length(z)*mean(z)^2;

rz2 = 100*numer/denom;
return