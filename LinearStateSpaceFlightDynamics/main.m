%{
A422 Project
Linear State-Space Flight Dynamics Identification of a Robotic
Hummingbird
Authors: Ethan Vieira, Jacob Watkins
%}
clc; clear; close all

%------------------------------------------------------------------
% FOR OBTAINING T(s), RUN THE FOR LOOP
% FOR OBTAINING GRAPHS OF EACH MODEL, RUN THE SINGLE OUTPUT OF INTEREST
% AND ENTER THE YLABEL OF AXIS HERE
ylab = 'phidot (rad/s^2)'


% loop through all 9 output models 

A = zeros(9);
B = zeros(9,4);
%for out = 1:9
% or enter model to run here and comment out for loop
out = 7;
    % determine which file to open based on desired output model
    if out == 1 | out == 5 | out == 8
        data = fopen('Longitudinal_excitation.txt', 'r');
    elseif out == 2 | out == 4 | out == 7
        data = fopen('Lateral_excitation.txt', 'r');
    elseif out == 3
        data = fopen('Heave_excitation.txt', 'r');
    else 
        data = fopen('Yaw_excitation.txt', 'r');
    end
    
    % save data in array A
    sizeA = [14 Inf];
    zeta = transpose(fscanf(data, '%f', sizeA));
    
    % calculate output with table derivative
    z = deriv(zeta(:,1:13), .02);
    
    
    
    % initialize regressor matrix
    X = zeros(length(z(:,1)), 13);
    
    % initialize number of parameters
    n = 0;
    R2 = 0;
    %-------------------------------------------------------------
    while R2 < 95
        
        n = n + 1;
        % calculate partial correlation coefficients
        if n > 1
            etta = zeta - X*param;
            v = z - X*param;
            z_pcc = pcc(v(:,out), etta);
        else
            z_pcc = pcc(z(:,out), zeta);
        end
        % find the column to choose as regressor
        out_pcc = z_pcc.';
        if n > 1
           out_pcc(col(n-1)) = 0;
        end
        
        col(n) = find(abs(out_pcc) == max(abs(out_pcc)));
        
        % insert the regressor into zero matrix
        for a = 1:n
            X(:,col(a)) = zeta(:,col(a));
        end

        % calculate the model parameers
        param = lsq(X, z(:,out));

        % calculate the partial F-Ratios
        fratio = pfr(X, z(:,out), param);

        % remove values less than 20 and recalculate the model

        % calculate the coeff of determination
        R2 = cod(X, z(:,out), param);

        % calculate the predicted square error
        pserr = pse(X, z(:,out), param, n); 
    end
    % print out stuff
 
    
    model = 0;
    for a = 1:(n)
        model = model + param(col(a))*zeta(:,col(a));
        % State Space Matrix
        if col(a) > 9
            B(out, col(a)-9) = param(col(a));
        else
            A(out, col(a)) = param(col(a));
        end
    end
    R2
    n
    
    % plot stuff
    figure(out)
    hold on
    plot(zeta(:,14),z(:,out))
    plot(zeta(:,14),model, '--')
    title('Output vs Time')
    xlabel('Time (s)')
    ylabel(ylab)
    fclose(data);
%     
%end
A;
B;
% eigenvalues and eigenvectors
[V, E] = eig(A);
eval = diag(E);
evec = diag(V);
dr = -real(E)./sqrt(real(E).^2+imag(E).^2);
DR = diag(dr);
wn = sqrt(real(E).^2+imag(E).^2);
WN = diag(wn);
wd = sqrt(1-dr.^2).*wn;
WD = diag(wd);
tc = (-1./E);
TC = diag(tc);

% Transfer Function
syms s
C = eye(9);
D = zeros(9, 4);
T = C*inv(s*C-A)*B+D;
simT = simplify(T);

% output T(s)
%vpa(simT, 4)

