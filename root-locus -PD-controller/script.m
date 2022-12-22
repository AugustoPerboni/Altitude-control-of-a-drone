
%% Inicializations
close all; clear all; clc;

M  = 1;   % Mass [kg]
Z0 = 2;% Inicial high [m]
G  = 9.8; % Gravity acelleration [m/s^2]
Kt = 3.575e-05; % Constant [N/(rad/s)^2] 

% Calculation of equilibrium omega
omega_0 = sqrt(G*M/Kt);  

%% Proportional controller for root-locus for K > 0
s = tf('s');
G_open = ( (600*Kt*omega_0)/((s^2)*(s+300)*M) );
rlocus(G_open);
title('Root-locus for K>0');
%%
% As we can see in the plot this system would always have poles on the right
% half-plane for k > 0, which means that it is unstable.

%% Proportional controller root-locus for K < 0
figure;
s = tf('s');
G_open = ( (-1)*(600*Kt*omega_0)/((s^2)*(s+300)*M) );
rlocus(G_open);
title('Root-locus for K<0');
%%
% To plot the root-locus for K < 0 the open loop transfer functions can be
% multiplied by a negative one. As we can see with K < 0 one pole still at
% the right half plane

%% Proportional derivative controller root-locus for K > 0

for z = [ 800 400 100 0 1 -50 -250 ]  
    figure;
    s = tf('s');
    G_open = ( (s+z) / (s^2 * ( s + 300) ) ); 
    rlocus(G_open)
    title(sprintf('Root-locus for z = %.1f',z));
end
%%
% As we can see in all the plots we have two poles at the origin and one pole
% at -300. Values of z were chosen carefully in order to have zeros in all
% the relative positions of the poles.
% Looking at the graphs it is possible to notice that the system will be
% stable for zeros between the poles. That is, z = [0,300]

%% Proportional derivative controller for z = 1 and double pole at s≈-2.01
% With some graphical analysis of the last session, it is possible to
% calculate the value of K that makes our system with two poles at -2.01
% K = 1.19e+03 

% Calculus of Kd and Kp
% z = Kp/Kd, z = 1 => Kp = Kd = ((K*M)/(600*kT*omega_0))
K = 1.19e+03;
Kd = ((K*M)/(600*Kt*omega_0));
Kp = Kd;
Zref = 1;
StopTime = 10;

simOut = sim("simulink.slx");
figure;
plot(simOut.dz.time,simOut.dz.signals.values); 
title('Step response of PD controller for z=1 and K = 1.19e+03');
xlabel('time(s)');
ylabel('z(m)');
%%
% As expected, once all the poles are negative, the system is stable and
% has a tracking error close to zero
   
for z = [ 400 100 1 -50]  
    K = 1000;
    Kd = ((K*M)/(600*Kt*omega_0));
    Kp = z*Kd;
    simOut = sim("simulink.slx");
    figure;
    plot(simOut.dz.time,simOut.dz.signals.values); 
    title(sprintf("Step response of PD controller for z = %d and K = %.1f",z,K));
    xlabel('time(s)');
    ylabel('z(m)');
end

for z = [ 400 100 1 -50]  
    K = -500;
    Kd = ((K*M)/(600*Kt*omega_0));
    Kp = z*Kd;
    simOut = sim("simulink.slx");
    figure;
    plot(simOut.dz.time,simOut.dz.signals.values); 
    title(sprintf("Step response of PD controller for z = %d and K = %.1f",z,K));
    xlabel('time(s)');
    ylabel('z(m)');
end
%%   
% Observing the results we can comfirm what we expected, the system is
% stable only for z between 0 and 300 and K > 0.






