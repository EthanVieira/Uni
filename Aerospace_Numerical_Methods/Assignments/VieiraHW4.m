% AERO 220
% Ethan Vieira
% HW 4

clear; close all; clc;
problem = 1 ; % choose which problem you want to run

switch(problem)
    
    case 1
      x = [10 50 75 95 85 80];
      y = [60 15 5 70 150 130];
      figure()
      scatter(x,y);
      grid on
      hold on
      N = length(x);
      n = N-1;
      BB = zeros(2*n-2,3*n);
      f = zeros(2*n-2,1);
      for i = 1:(n-1)
          row = 2*(i-1)+1;
          BB(row,i) = x(i+1)^2;
          BB(row+1,i+1) = x(i+1)^2;
          BB(row,n+i) = x(i+1);
          BB(row+1,n+i+1) = x(i+1);
          BB(row,2*n+i) = 1;
          BB(row+1, 2*n+i+1) = 1;
          f(row) = y(i+1);
          f(row+1) = y(i+1);
      end
      
      B1 = zeros(n-1,3*n);
      for i = 1:(n-1)
          B1(i,i) = 2*x(i+1);
          B1(i,i+1) = -2*x(i+1);
          B1(i,n+i) = 1;
          B1(i,n+i+1) = -1;
      end
      
      BE = zeros(2,3*n);
      BE(1,1) = x(1)^2;
      BE(1,n+1) = x(1);
      BE(1,2*n+1) = 1;
      BE(2,n) = x(end)^2;
      BE(2,2*n) = x(end);
      BE(2,end) = 1;
      
      H = [BB;B1;BE];
      [r,c] = size(H);
      
      K = zeros(r,1);
      K(1:(2*(n-1))) = f;
      K(end-1) = y(1);
      K(end) = y(end);
      
      H = H(:,2:end);
      coeff = inv(H)*K;
      A = [0;coeff(1:n-1)];
      B = coeff(n:2*n-1);
      C = coeff(2*n:end) ;
      
      for i=1:n
           xSpline = linspace(x(i),x(i+1),10);
           ySpline = A(i)*xSpline.^2+B(i)*xSpline+C(i);
           p2 = plot(xSpline,ySpline);
      end
      
    case 2
      x = [10 50 75 95 85 80];
      y = [60 15 5 70 150 130];
      pt1 = [10;60]; pt2 = [50;15]; pt3 = [75;5]; pt4 = [80;130];
      pt5 = [85;150]; pt6 = [95;70];
      t = linspace(0,1,101);
      figure()
      scatter(x,y);
      grid on 
      hold on
      pts = kron((1-t).^5,pt1)+kron(5*t.*(1-t).^4,pt2)+kron(10*t.^2.*(1-t).^3,pt3)+kron(10*t.^3.*(1-t).^2,pt4)+kron(5*t.^4.*(1-t),pt5)+kron(t.^5,pt6);
      
      plot(pts(1,:),pts(2,:))
    case 3
      x = [10 50 75 95 85 80];
      y = [60 15 5 70 150 130];
      figure()
      scatter(x,y);
      grid on
      hold on
      N = 100;
      u = linspace(0,1,N); u2 = u.*u; u3 = u2.*u;
      b1 = 1/6*(1-u).^3; b2 = u3/2-u2+2/3;
      b3 = (-u3+u2+u+1/3)/2; b4 = u3/6;
      n = length(x);
      for k = 1:n-3
          X = b1*x(k)+b2*x(k+1)+b3*x(k+2)+b4*x(k+3);
          Y = b1*y(k)+b2*y(k+1)+b3*y(k+2)+b4*y(k+3);
          if mod(k, 2) == 1
              plot (X,Y, 'r-', 'LineWidth', 3);
          else
              plot(X,Y, 'k-', 'LineWidth', 3);
          end
      end
    case 4
        n = 5; 
        d = 3;
        x = linspace(-1,1,n);
        t = linspace(-1,1);
        y = sin(x).*exp(-x.^2)
        figure()
        scatter(x,y)
        grid on 
        hold on
        coeff = polyfit(x,y,d);
        p = polyval(coeff,t);
        plot(t,p)
    case 5
        
        
        n = 5;
        
        x = linspace(-1,1,n);
        t = linspace(-1,1);
        y = sin(x).*exp(-x.^2);
        figure()
        scatter(x,y)
        grid on
        hold on
        L = 0;
        S = sin(2*x);
        C = cos(2*x);
        F = sum(S.^2);
        B = sum(C.*S);
        D = sum(C.^2);
        M = [F B; B' D];
        f = [sum(y.*S); sum(y.*C)];
        coeff = M\f;
        A = sqrt(coeff(1)^2+coeff(2)^2)
        phi = asin(coeff(2)/A)
        y2 = A*sin(2*t+phi);
        plot(t,y2)
            
        
    otherwise 
        error('Invalid Problem Number');
        
        
        
end

