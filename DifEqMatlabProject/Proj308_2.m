function proj308_2()
%{
Math 308 Matlab Project Spring 2016
Initial-Value Problems for Ordinary Differential Equations
Authors: Ethan Vieira, Akash Kundu, Aisyah Abir
%}
clear; clc; close all
% 2.1 Test Problem

sysyE(0, 100, [2, 3], .01)

% 2.2 Improved Euler

sysyIE(0, 100, [2, 3], .01)


% 2.3 Beats and Resonance
w = [1.7 1.8 1.9 1.95 1.99];
sysY(0, 100, [0, 0], .001, w)

sysIY(0, 100, [0, 0], .01, w)


end

function E1 = sysyE(t0, tf, y0, h) % (T initial, T final, Y initial, step size)
y(:,1) = y0;

t = t0: h : tf; % create a vector of t-values

for i = 1:length(t)-1
    k1 = f1(t(i),y(:,i));
    y(:,i+1) = y(:,i) + h*k1;
    if i == 1
            fprintf('----------------------------------------------\n')
            fprintf('h = %-.3f System Euler Method \n',h)
            fprintf('----------------------------------------------\n')
    end

    if rem(t(i),1) == 0
        fprintf('%-2g  \t %-8.6f \n', t(i), y(i))
    end
                
end

YhE = y(1,end);
figure(1)
plot(t,y(1,:)) 
xlabel('t'), ylabel('y'), title('y(t), Euler method')


end

function E2 = sysyIE(t0, tf, y0, h) % (T initial, T final, Y initial, step size)
y(:,1) = y0;

t = t0: h : tf; % create a vector of t-values

for i = 1:length(t)-1
    k1 = f1(t(i),y(:,i));
    k2 = f1(t(i)+h,y(:,i)+h*k1);
        
    y(:,i+1) = y(:,i) + (h/2)*(k1+k2);
    if i == 1
        fprintf('----------------------------------------------\n')
        fprintf('h = %-.3f System Euler Method \n',h)
        fprintf('----------------------------------------------\n')
    end

     if rem(t(i),1) == 0
        fprintf('%-2g  \t %-8.6f \n', t(i), y(i))
    end
               
end

YhIE = y(1,end);
figure(2)
plot(t,y(1,:)) 
xlabel('t'), ylabel('y'), title('y(t), Improved Euler method')
end

function E3 = sysY(t0, tf, y0, h, a)
y(:,1) = y0;

t = t0: h : tf; % create a vector of t-values
NA = length(a);
for j = 1:NA
    for i = 1:length(t)-1
        k1 = f2(t(i),y(:,i),a(j));
        y(:,i+1) = y(:,i) + h*k1;
        if i == 1
                fprintf('----------------------------------------------\n')
                fprintf('w = %-.3f System Euler Method \n',a(j))
                fprintf('----------------------------------------------\n')
        end

        if rem(t(i),1) == 0
            fprintf('%-2g  \t %-8.6f \n', t(i), y(i))
        end

    end
Yh(j) = y(1,end);
figure(j+2)
plot(t,y(1,:)) 
xlabel('t'), ylabel('y'), title(sprintf('y(t), w = %g Euler method', a(j)))



end
end
function E4 = sysIY(t0, tf, y0, h, a)
y(:,1) = y0;

t = t0: h : tf; % create a vector of t-values
NA = length(a);
for j = 1:NA
    for i = 1:length(t)-1
        k1 = f2(t(i),y(:,i),a(j));
        k2 = f2(t(i)+h,y(:,i)+h*k1,a(j));
        y(:,i+1) = y(:,i) + (h/2)*(k1+k2);
        if i == 1
                fprintf('----------------------------------------------\n')
                fprintf('w = %-.3f System Euler Method \n',a(j))
                fprintf('----------------------------------------------\n')
        end

        if rem(t(i),1) == 0
            fprintf('%-2g  \t %-8.6f \n', t(i), y(i))
        end

    end
Yh(j) = y(1,end);
figure(8)
plot(t,y(1,:))
xlabel('t'), ylabel('y'), title(sprintf('y(t), w = %g Improved Euler method', a(j)))
   
end

end


% y"+y'+5/4y=3cos(t)

function f = f1(t,y) % define f(t,Y)
  f = [0 1; -5/4 -1]*y + [0;3*cos(t)];  
end

% y"+4y=cos(wt)

function f = f2(t,y,a)
f = [0 1; -4 0]*y + [0;cos(a*t)];
end