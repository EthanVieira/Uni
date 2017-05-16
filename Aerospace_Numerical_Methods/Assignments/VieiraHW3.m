 % AERO 220
% Ethan Vieira
% HW 3

clear; close all; clc;
problem = 6 ; % choose which problem you want to run

switch(problem)
    
    case 1
        
        A = [5 6 7 5 -1; 8 -4 -1 0 -3; 2 1 -1 3 6; -9 10 1 -4 6; 9 5 -5 -8 4];
        b = [-3; 5; 2; 9; -2];
        n = length(b);
        for i = 1:n            % Diagonally dominant
            A(i,i) = sum(abs(A(i,1:5)));
        end
        iter = 0;
        eps = 10^-6;
        err = 1;                
        x_t = A\b;
        D = diag(diag(A));
        O = A-D;
        x = [0;0;0;0;0];
        Dinv = inv(D);
        while abs(err)>eps
            x1 = Dinv*b-Dinv*O*x;
            x = x1;
            err = norm(x_t-x);
            iter = iter+1;
        end
        err
        iter
        x

    case 2
        A = [5 6 7 5 -1; 8 -4 -1 0 -3; 2 1 -1 3 6; -9 10 1 -4 6; 9 5 -5 -8 4];
        b = [-3; 5; 2; 9; -2];
        n = length(b);
        for i = 1:n            % Diagonally dominant
            A(i,i) = sum(abs(A(i,1:5)));
        end
        iter = 0;
        eps = 10^-6;
        err = 1;               
        x_t = A\b;
        n = length(A);
        x = [0;0;0;0;0];       
        while abs(err) > eps
            for i = 1:n
                x(i) = (1/A(i, i))*(b(i) - A(i, 1:n)*x + A(i, i)*x(i));                        
            end
            err = norm(x_t-x); 
            iter = iter + 1;
        end
        iter
        x
        err
    case 3
        
      f1 = @(x,y) y + sqrt(x);
      f2 = @(x,y) (x-3)^2+y^2-5;
      %% a
      i = 0;
      eps = 10^-4;
      err = [inf inf];
      
      x0 = 1; y0 = 0;
      while norm(err) > eps
          df1dx = .5*x0^(-.5); df1dy = 1;
          df2dx = 2*x0-6; df2dy = 2*y0;
          J = [df1dx df1dy; df2dx df2dy];
          
          f = [f1(x0,y0); f2(x0,y0)];
          d = -J\f;
          x = d(1) + x0;
          y = d(2) + y0;
          err = [x-x y-y0];
          accuracy = [abs(f1(x,y)) abs(f2(x,y))];
          x0 = x; y0 = y;
          i = i + 1;       
      end
      i
      x,y
      accuracy
      
      %% b
      i = 0;
      eps = 10^-4;
      err = [inf inf];
      x0 = 5; y0 = -2;

      while norm(err) > eps
          df1dx = .5*x0^(-.5); df1dy = 1;
          df2dx = 2*x0-6; df2dy = 2*y0;
          J = [df1dx df1dy; df2dx df2dy];
          
          f = [f1(x0,y0); f2(x0,y0)];
          d = -J\f;
          x = d(1) + x0;
          y = d(2) + y0;
          err = [x-x0 y-y0];
          accuracy = [abs(f1(x,y)) abs(f2(x,y))];
          x0 = x; y0 = y;
          i = i + 1;       
      end
      i
      x,y
      accuracy
      
    case 4
        x = [4.1168 4.19236 4.20967 4.46908]';
        y = [0.213631 0.214232 0.21441 0.218788]';
        V = [ones(4,1) x x.^2 x.^3];
        c = V\y
        
        
    case 5
        x = [4.1168 4.19236 4.20967 4.46908];
        f1 = @(x) pi*x.^3-7*x.^2+sin(x)-1;
        n = length(x);
        A = zeros(n);
        A(:,1) = f1(x);
        for i = 2:n
            for j = 1:n+1-i
                A(j,i) = (A(j+1,i-1) - A(j,i-1))/(x(i+j-1) - x(j));
            end
        end
        A
    case 6
        
        r2 = .25;
        r3 = .4;
        a = .1;
        t2 = pi/4;
        f1 = @(t3,r1) r2*cos(t2)-r1-r3*cos(t3);
        f2 = @(t3,r1) a+r2*sin(t2)-r3*sin(t3);
        t3_0 = pi/3;
        r1_0 = .5;
        eps = 10^-5;
        err = 1;
        i = 0;
        while norm(err) > eps
          df1dt3 = -r3*cos(t3_0); df1dr1 = -1;
          df2dt3 = r3*sin(t3_0); df2dr1 = 0;
          J = [df1dt3 df1dr1; df2dt3 df2dr1];
          
          f = [f1(t3_0,r1_0); f2(t3_0,r1_0)];
          d = -J\f;
          t3 = d(1) + t3_0;
          r1 = d(2) + r1_0;
          err = [t3-t3_0 r1-r1_0];
          t3_0 = t3; r1_0 = r1;
          i = i + 1;       
        end
        t3 = pi-t3, r1
    otherwise 
        error('Invalid Problem Number');
        
end
      
    
        