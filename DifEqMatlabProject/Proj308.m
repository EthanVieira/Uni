function Proj308()
clear; clc; close all
%{
Math 308 Matlab Project Spring 2016
Initial-Value Problems for Ordinary Differential Equations
Authors: Ethan Vieira, Akash Kundu, Aisyah Abir
%}

% 1.1 Euler's Method

yE(0, 2, 1, .01) % (T initial, T final, Y initial, step size(s) (if entering an array, [h1 h2 h3...])

% 1.2 Improved Euler's Method

yIE(0, 2, 1, .01) 

% 1.3 Runge-Kutta Method (RK4)

yKR(0, 2, 1, .05)

% 1.4  Plots 1-2: Convergence Rates for Euler Methods

N = [1/5 1/10 1/20 1/40 1/80 1/160 1/320 1/640 1/1280 1/2560];

yE(0, 1, 1, N)

yEerror = getGlobalx;

figure(1)
loglog(N, N)
hold on
loglog(N, yEerror)
xlabel('h'), ylabel('h, yE error'), title('loglog-plot of h vs h and h vs euler error')
legend('h vs h', 'h vs yE error')

yIE(0, 1, 1, N)

yIEerror = getGlobalx;

figure(2)
loglog(N, N.^2)
hold on
loglog(N, yIEerror)
xlabel('h'), ylabel('h^2, yIE error'), title('loglog-plot of h vs h^2 and h vs improved euler error')
legend('h vs h^2', 'h vs yIE error')
% 1.5 Plot 3: Convergence Rates for Runge-Kutta Method

yKR(0, 1, 1, N)

yKRerror = getGlobalx;

figure(3)
loglog(N, N.^4)
CE1 = polyfit(log(N), log(N.^4), 1);
slope1 = CE1(1);
hold on

loglog(N, yKRerror)
CE = polyfit(log(N), log(yKRerror), 1);
slope = CE(1)
xlabel('h'), ylabel('h^\alpha, yKR error'), title('loglog-plot of h vs h^\alpha and h vs error')
legend('h vs h^\alpha', 'h vs yKR error')



end

function E1 = yE(t0, tf, y0, hvect) % (T initial, T final, Y initial, step size(s))

% Euler's Method

NH = length(hvect);

for m = 1:NH;
    h = hvect(m);
    t = t0 : h : tf; % vector of t-values
    y(1) = y0;
    n = length(t);
    for i = 1:n
        k1 = f1(t(i),y(i));
        y(i+1) = y(i) + h*k1;
        if i == 1
            fprintf('----------------------------------------------\n')
            fprintf('h = %-.3f Euler Method \n',h)
            fprintf('----------------------------------------------\n')
        end

       
        if numel(num2str(t(i))) <= 3
            fprintf('%-2g  \t %-8.6f \n', t(i), y(i))
            
        end
    end
  
     yEh(m) = y(end-1);
     yEerror(m) = abs(yexact(1) - yEh(m));
     setGlobalx(yEerror);
end    
end

function E2 = yIE(t0, tf, y0, hvect) % (T initial, T final, Y initial, step size(s))

%  Improved Euler's Method

NH = length(hvect);
for m = 1:NH;
    h = hvect(m);
    t = t0 : h : tf; % vector of t-values
    y(1) = y0;
    n = length(t);
    for i = 1:n
        k1 = f1(t(i),y(i));
        k2 = f1(t(i)+h,y(i)+h*k1);
        y(i+1) = y(i) + (h/2)*(k1+k2);
        if i == 1
            fprintf('----------------------------------------------\n')
            fprintf('h = %-.3f Improved Euler Method \n',h)
            fprintf('----------------------------------------------\n')
        end
        j = 1;
        if numel(num2str(t(i))) <= 3
            fprintf('%-2g  \t %-8.6f \n', t(i), y(i))
            yIE(j) = y(i);
            j = j + 1;
        end
    end
    yIEh(m) = y(end-1);
    yIEerror(m) = abs(yexact(1) - yIEh(m));
    setGlobalx(yIEerror);
end
end

function E3 = yKR(t0, tf, y0, hvect) % (T initial, T final, Y initial, step size(s))

% Runge-Kutta Method (RK4)

NH = length(hvect);
for m = 1:NH;
    h = hvect(m);
    t = t0 : h : tf; % vector of t-values
    y(1) = y0;
    n = length(t);
    for i = 1:n
        k1 = f1(t(i),y(i));
        k2 = f1(t(i)+.5*h, y(i)+.5*h*k1);
        k3 = f1(t(i)+.5*h, y(i) + .5*h*k2);
        k4 = f1(t(i)+h, y(i)+h*k3);
        y(i+1) = y(i) + (h/6)*(k1+2*k2+2*k3+k4);
        if i == 1
            fprintf('----------------------------------------------\n')
            fprintf('h = %-.3f Runge-Kutta Method \n',h)
            fprintf('----------------------------------------------\n')
        end
        j = 1;
        if numel(num2str(t(i))) <= 3
            fprintf('%-2g  \t %-8.6f \n', t(i), y(i))
            yRK(j) = y(i);
            j = j + 1;
        end
    end
    yKRh(m) = y(end-1);
    yKRerror(m) = abs(yexact(1) - yKRh(m));
    setGlobalx(yKRerror);
end
end

% Setting/Retrieving Global Variables. Used to retrieve error values.

function r = setGlobalx(val)
global x
x = val;
end

function r = getGlobalx
global x
r = x;
end

% Function f

function f = f1(t,y) % define f(t,y)
f = 1-t+4*y;
end

% Exact Values

function f = yexact(t)
f = 1/4*t - 3/16 + 19/16*exp(4*t);
end


