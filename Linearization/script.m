
%% Inicializations
close all; clear all; clc;

M  = 1;   % Massa [kg]
Z0 = 2;% Altura inicial [m]
G  = 9.8; % Aceleracao da gravidade [m/s^2]
Kt = 3.575e-05; % Constante [N/(rad/s)^2] 

  

%% Comparisom between linear and non linear
% Em equilibrio:
%   omega = omega_0 = U0
%   linear aceleration = linear velocity = angular aceleration = 0

% Calculus of equilibrium omega 
omega_0 = sqrt(G*M/Kt); 


StopTime = 100; % Simulation stop time 

% Plots of the linear equation for different values delta omega
figure;
hold on;
for StepSize = [100, 1000, 5000].*2.*pi./60 % RPM ro rad/s
    simOut = sim("simulink.slx");
    plot(simOut.dz.time,simOut.dz.signals.values); 
    plot(simOut.z.time,simOut.z.signals.values);
end
legend('Linear 100 RPM','100 RPM','Linear 1000 RPM','1000 RPM','Linear 5000 RPM','5000 RPM');
hold off;












