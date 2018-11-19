function thetaz = lsq(X, z)

%{
This function calculates the Least Squares solution for model
parameters, thetaz_hat, for inputs X (Nx13), the selected regressor matrix,
and z (1x13), the output data. The output is a 1x13 array of the model 
parameters.
%}

thetaz = misvd(X.'*X)*X.'*z;

return