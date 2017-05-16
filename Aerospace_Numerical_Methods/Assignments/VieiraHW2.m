% AERO 220
% Ethan Vieira
% HW 2

clear; close all; clc;
problem = 1 ; % choose which problem you want to run

switch(problem)
    
    case 1
        %%
        
        f = @(c) 10^6-10^5*c-.25*10^6*sqrt(c);
        g = @(c) (10^6-.25*10^6*sqrt(c))/10^5;
        % f(4.6241) Matlab's fzero function's approximation of the root
        %Graphed stuff 
        %x = -5:0.01:5;
        %figure()
        %plot(x,f(x))
        %hold on
        %plot(x,g(x))
        
        c0 = 4; %initial guess
        c1 = g(c0);
        while abs(c1-c0) > 0.1
            c0 = c1;
            c1 = g(c0);
        end
        c0
        c1
        
       
    case 2
        %% a
        
        f = @(x) -x^3+2*x-exp(-x)+3;
        fprime = @(x) -3*x^2+2+exp(-x);
        N = @(x) x - (-x^3+2*x-exp(-x)+3)/(-3*x^2+2+exp(-x));
        x0=2.3;
        x1=N(x0);
        
        for i = 1:6
            x_n(i) = x0; % saving for table
            x0 = x1;
            x1 = N(x0);
        end
        x1
        T = array2table(x_n)
        alpha = (log(abs(x_n(3)-x1))-log(abs(x_n(2)-x1)))/(log(abs(x_n(2)-x1))-log(abs(x_n(1)-x1)))   
        lambda = abs(x_n(2)-x1)/abs(x_n(1)-x1)^alpha
        %% b
        g = @(x) (-x.^3-exp(-x)+3)/-2;
        gprime = @(x) (-3*x.^2+exp(-x))/-2;
        x = -3:.1:3;
        figure()
        plot(x, gprime(x))
        % Does not converge
   
    case 4
        A = [2 1 -1; 4 1 2; 6 1 1];
        B = [-2;4;6];
        n = size(A,1); 
        % To get the matrix in upper triangular form
        for k = 1:n-1
            for i = k+1:n
                if A(i,k)~= 0
                    c = A(i,k)/A(k,k);
                    A(i,k:n) = A(i,k:n) - c*A(k,k:n);
                    B(i) = B(i) - c*B(k);
                end
            end
        end
        % To substitute for solutions
        for k = n:-1:1
            B(k) = (B(k) - A(k,k+1:n)*B(k+1:n))/A(k,k);
        end        
        B      
        
    case 5
        %%a
        
        A = [-3 1 -2; 2 3 0;-1 2 3];
        B = [3 -2 5; 2 -4 1; -4 1 6];
        B*A
        B^3
        A*A'
        
        %%b 
        A1 = A(1,1:3);  A2 = A(2,1:3); A3 = A(3,1:3);
        B1 = B(1,1:3);  B2 = B(2,1:3); B3 = B(3,1:3);
        detA = dot(A1,cross(A2,A3))
        detB = dot(B1,cross(B2,B3))
               
        %%c
        
        %Using Doolittle's decomposition method
        
        [z y]=size(A);
        if (z ~= y )
            disp ( 'Matrix is not square' );
            return;
        end;

        if det(A)==0
            disp('det is zero');
            return;
        end
        
        n = size(A,1);
        for k = 1:n-1
            for i = k+1:n
                if A(i,k) ~= 0
                    c = A(i,k)/A(k,k);
                    A(i,k+1:n) = A(i,k+1:n) - c*A(k,k+1:n);
                    A(i,k) = c;
                end
            end
        end
        A
        
        [z y]=size(B);
        if (z ~= y )
            disp ( 'Matrix is not square' );
            return;
        end;

        if det(B)==0
            disp('L singular error');
            return;
        end
        n = size(B,1);
        for k = 1:n-1
            for i = k+1:n
                if B(i,k) ~= 0
                    c = B(i,k)/B(k,k);
                    B(i,k+1:n) = B(i,k+1:n) - c*B(k,k+1:n);
                    B(i,k) = c;
                end
            end
        end
        B
        %% d
        B = [3 -2 5; 2 -4 1; -4 1 6];
        I = eye(3,3);

        [r,c] = size(B);
        for j = 1 : r
            for i = j : r
                if B(i,j) ~= 0
                    for k = 1 : r
                    s = B(j,k); B(j,k) = B(i,k); B(i,k) = s;
                    s = I(j,k); I(j,k) = I(i,k); I(i,k) = s;
                    end


                    t = 1/B(j,j);
                    for k = 1 : r
                        B(j,k) = t * B(j,k);
                        I(j,k) = t * I(j,k);
                    end
                    for L = 1 : r
                        if L ~= j
                        t = -B(L,j);
                            for k = 1 : r
                            B(L,k) = B(L,k) + t * B(j,k);
                            I(L,k) = I(L,k) + t * I(j,k);
                            end
                        end
                    end 
                end       
            end
        end
       
        B
        I
        
        
        
    otherwise 
        error('Invalid Problem Number');
        
end
      
    
        