% AERO 220
% Ethan Vieira
% HW 1

clear; close all; clc;
problem = 2 ; % choose which problem you want to run

switch(problem)
    
    case 2
        %% a
        x = 1.32;
        f = 3.15*x^2-2.11*x+4.01 
        a = chop(x^2,3); % Approximating to 3 sig figs
        b = chop(a*3.15,3);
        c = chop(2.11*x,3);
        d = chop(b-c,3);
        approx = chop(d+4.01,3)
        absError = abs(f-approx) % Absolute Error
        relError = absError/abs(f) % Relative Error
        %% b
        f = (3.15*x-2.11)*x+4.01
        a = chop(3.15*x,3); % Approximating to 3 sig figs
        b = chop(a-2.11,3);
        c = chop(b*x,3);
        approx = chop(c+4.01,3)
        absError = abs(f-approx) % Absolute Error
        relError = absError/abs(f) % Relative Error
    case 3
        %% a
        % initializing
        approx = 0;
         
        % loop Taylor Series through all i values
        for i = 0:7
            a = chop((-1)^i,4);
            b = chop(4^i,4);
            c = chop(a*b,4);
%              Going to assume factorial not needed to be chopped, but if it 
%              would (high i values) here is the code                
%              if i>1                 
%                  d = 1;
%                  y = 2;
%                  for j = 1:i-1                    
%                      d = chop(d*y,4);
%                      y = y+1;
%                  end                                          
%                  approx = chop(approx + chop(c/d,4),4)                  
%              else
%                  approx = approx + c
%               end
             %  Comment out next line if using the code above      
             approx = chop(approx + chop(c/factorial(i),4),4);   
        end
        approx
        %% b 
        approx = 0;
        for i = 0:7
            a = chop(4^i,4);
            b = chop(a/factorial(i),4);
            approx = chop(approx + chop(1/b,4),4);
        end 
        approx
        
    case 4
        %% a
        x = linspace(0.5,5);
        xmid = (0.5+5)/2;
        e = 0.1;
        a = 0.5;
        b = 5;
        while abs(log(xmid)) > e
            xmid = (a+b)/2;               
            if sign(log(xmid)) == sign(log(a))
                a = xmid;
            else 
                b = xmid;
            end
        end
        root = xmid
        
        %% b
        e = .1;
        x0 = 0.5;
        x1 = 5;
        x = x0;
        while abs(log(x)) > e 
            x = x0-log(x0)*(x1-x0)/(log(x1)-log(x0));
            x0 = x1;
            x1 = x;
        end
        root = x
        
    case 6
        %%
        
        p0 = 415;
        p1 = 350;
        x = -100:100;
        M1 = .5;
        answer = p0/p1;
        f = @(x) (1+(x-1)/2*M1.^2).^(x/(x-1))-answer;
        %plotting to get a good starting guess for a and b
        %plot(x,f(x))
        e = 0.00001;
        a = -5;
        b = 5;
        xmid = (a+b)/2;
        while abs(f(xmid)) > e 
            xmid = (a+b)/2;
            if sign(f(xmid)) == sign(f(a))
                a = xmid;
            else
                b = xmid;
            end            
        end
        k = xmid   
    otherwise 
        error('Invalid Problem Number');
        
end
      
    
        