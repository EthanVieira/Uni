% AERO 310
% Ethan Vieira
% Term Paper
function BallMotion
clear; clc; close all

dist = linspace(35,35); % Ball distance from goal in meters
a = 2.44;% goal height 
a1 = linspace(a,a); 
a2 = linspace(0,a);
d = 7.32; %goal length
d1 = linspace(-d/2,d/2); % half of goal length
d2 = linspace(d/2,d/2);


%Initial Conditions

x0 = 1; % m
dx0 = 18;
y0 = 0; % m
dy0 = 35;
z0 = 0; % m
dz0 = 8;

tstart = 0;
tend = 1.75;
n = 1000;
tspan = linspace(tstart,tend,n);

xinit = [x0; dx0; y0; dy0; z0; dz0];

[t,x] = ode45(@integratingfunction,tspan,xinit)

x1 = x(:,1);
xdot = x(:,2);
y = x(:,3);
ydot = x(:,4);
z = x(:,5);
zdot = x(:,6);

hold on
plot3(d1,dist,a1)
plot3(d2,dist,a2)
plot3(-d2,dist,a2)

curve = animatedline('Color', 'b');
for i = 1:length(tspan)
    addpoints(curve,x(i,1),x(i,3),x(i,5));
    drawnow
end

% plot3(x1,y,z)
xlabel('ex');
ylabel('ey');
zlabel('ez');

figure 
hold on
plot(t,x1)
plot(t,y)
plot(t,z)
legend('x', 'y', 'z')
end


function dxdt = integratingfunction(t,x)

rho = 1.225; % Air density Kg/m^3
Cd = .5; % Drag Coeff
R = .11; % m
w0 = 3.25; % rev/s
m = .425; % kg
theta = .1; % rad
g = 9.81; % m/s^2

x1=x(1);
xdot=x(2);
y=x(3);
ydot=x(4);
z=x(5);
zdot=x(6);

dxdt = zeros(size(x));
dxdt(1) = xdot;
dxdt(2) =(-16/3*pi^2*R^3*rho*w0*ydot*cos(theta)-.5*rho*sqrt(xdot^2+ydot^2+zdot^2)*pi*R^2*Cd*xdot)/m;
dxdt(3) = ydot;
dxdt(4) = (16/3*pi^2*R^3*rho*w0*(xdot*cos(theta)-zdot*sin(theta))-.5*rho*sqrt(xdot^2+ydot^2+zdot^2)*pi*R^2*Cd*ydot)/m;
dxdt(5) = zdot;
dxdt(6) = (16/3*pi^2*R^3*rho*w0*ydot*sin(theta)-.5*rho*sqrt(xdot^2+ydot^2+zdot^2)*pi*R^2*Cd*zdot-m*g)/m;

end
