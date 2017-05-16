%{
Math 308 Matlab Project Spring 2016
Initial-Value Problems for Ordinary Differential Equations
Authors: Ethan Vieira, Akash Kundu, Aisyah Abir
%}

% change the '1.7' in the dsolve line below to change w value

% dsolve and normal plot

sol = dsolve('Dy1=y2','Dy2=-4*y1+cos(1.7*t)','y1(0)=0','y2(0)=0','t');

figure(1)
ezplot(sol.y2, [0, 100])
% un-comment next line if you want the graph of sum of both solutions
%ezplot(sol.y1+sol.y2, [0, 100])

% phase plot

figure(2)
tval = (0:.1:100)'; % column vector with t-values
yval = double(subs([sol.y1,sol.y2],'t',tval)); % 2 columns with y1,y2
plot(yval(:,1),yval(:,2)) % plot col.2 of yval vs. col.1 of yval