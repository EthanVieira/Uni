function psez = pse(X, z, thetaz, n)

%{
This function calculates the Predicted Square Error, psez for
inputs X (Nx13),the selected regressor matrix, z (1x13),  
the output data, thetaz_hat (1x13), the model parameters, and n, the 
number of terms in the current model. The output is a single numerical
value for each of the modeled outputs.
%}

for i = 1:length(z)
    sigtemp(i) = (z(i)-mean(z))^2;
end
sigmax = sum(sigtemp)/(length(z)-1);

temp = X*thetaz;
for i = 1:length(z)
    psetemp(i) = (z(i)-temp(i))^2;
end
psez = (sum(psetemp(i))+sigmax*n)/length(z);

return