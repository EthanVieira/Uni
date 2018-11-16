%Ethan Vieira
%AERO 351 Project 2


clear; clc; close all

% Radial Variation Formula
x = linspace(0,1);
r = .5*(.74-.28*x);
cp = 1004;
T1 = 288; 
gam = 1.4;
R = 287;

%Calculating Everything
V1 = 183;
U = r*2*pi*9500/60;
W1 = sqrt(U.^2+V1^2);
Beta1 = atan(U/V1);
Beta15 = Beta1 - 18*pi/180;
W15 = V1*tan(Beta15);
V15 = U-W15;
alpha = atan(V15/V1);

mdot = 1.23*.26*V1;
T = mdot*(-r).*V15;
P = T*2*pi*9500/60;
wc = P/mdot;
T1s = T1*cp;
h1s = T1s+V1^2/2;
h2s = h1s + abs(wc);
T2s = h2s/cp;
psrat = (T2s/T1s).^(gam/(gam-1));

Rp = .5-V1./(2*U).*(tan(-Beta15)+tan(0));
FC = V1./U;
WC = 2*FC.*(tan(0)-tan(alpha));
Hn = W15./W1;
M = (U+W1)/sqrt(gam*R*T1);


%Plots


figure(1)
plot(r,Beta1)
title('Radial Variation of the Camber Line of the Rotor')
xlabel('Radius (m)')
ylabel('Beta_1 (rad)')

figure(2)
plot(r, alpha)
title('Radial Variation of the Camber Line of the Stator')
xlabel('Radius (m)')
ylabel('Alpha_{1.5} (rad)')

figure(3)
plot(r,h2s)
title('Radial Variation of the Total Enthalpy at the Exit')
xlabel('Radius (m)')
ylabel('h2^* (J*10^5)')

figure(4)
plot(r,psrat)
title('Radial Variation of the Total-to-Total Pressure Ratio')
xlabel('Radius (m)')
ylabel('Total Pressure Ratio')

figure(5)
hold on
plot(r,Rp)
plot(r,FC)
plot(r,WC)
plot(r,M)
plot(r,Hn)
title('Radial Variation of Various Values')
xlabel('Radius (m)')
legend('Degree of Reaction','Flow Coefficient','Work Coefficient','Mach Number','De Haller Number','')
