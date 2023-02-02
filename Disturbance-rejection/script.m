%% Inicializations
close all; clear; clc;

M  = 1;   % Mass [kg]
Z0 = 2;% Inicial high [m]
G  = 9.8; % Gravity acelleration [m/s^2]
Kt = 3.575e-05; % Constant [N/(rad/s)^2] 

% Calculation of equilibrium omega
omega_0 = sqrt(G*M/Kt); 

%% Q4.2

vz1 = [-400 -10 -1 1 10 100];
vz2 = [-400 -10 -1 1 10 100];
for jj = 1:length(vz2)
    for ii = 1:length(vz1)
        figure
        z1 = vz1(jj);
        z2 = vz2(ii);
        s = tf('s');
        G_open = (s + z1) * ( s + z2)/ (s^3*(s+300));
        rlocus(G_open)
        title(sprintf('z1 = %d  z2 = %d',z1,z2))
        snapnow;
        close all
    end
end


%% Q4.3
% Print the graph for z1 = 1 and z2 = 10 in order
% to identify the desired K
figure
z1 = 1;
z2 = 10;
s = tf('s');
G_open = (s + z1) * ( s + z2)/ (s^3*(s+300));
rlocus(G_open)
snapnow;
close all

K = 1.17e+04;
Kd = K*M/(600*Kt*omega_0);
Kp = Kd*(z1 + z2);
Ki = Kd*z1*z2;


StopTime = 10;
Zref = 1;
simOut = sim("sim_session6_2023.slx");
figure;
plot(simOut.dz.time,simOut.dz.signals.values); 
title(sprintf("Step response of PD controller for z1=%.1f, z2=%.1f " + ...
    "                               and K = %.1f",z1,z2,K));
maxh=max(simOut.dz.signals.values);
xlabel('time(s)');
ylabel('z(m)');
snapnow;
close all
%%
%The system is stable with a slight peak before stabilizing with and
%overshoot of 0.1799m which it quite low, the rise, peak and settling times
%are wall within 1 second which means the system is quite responsive. To
%reduce the overshoot some damping could be added to the system.

%% Q 4.4
%For zeros near -300 we can only analyze the RootLocus.

vz1 = [-300, -300, -10, -10];
vz2 = [-300, -250, -10, 10];
vK = [1000,1000,1000,1000];

for jj = 1:length(vz2)
            figure
            K = vK(jj);
            z1 = vz1(jj);
            z2 = vz2(jj);
            Kd = K*M/(600*Kt*omega_0);
            Kp = Kd*(z1 + z2);
            Ki = Kd*z1*z2;
            s = tf('s');
            G_open = (s + z1) * ( s + z2)/ (s^3*(s+300));
            rlocus(G_open);
            title(sprintf('z1 = %.1f  z2 = %.1f',z1,z2))
            snapnow;
end
%%
% as it is clear, all systems with zeros near -300 are unstable by analysis
% of the Rootlocus, due to Simulink limitations we will not analyze their
% step responses but it is safe to assume they'd go to infinity or zero.

vz1 = [10, 10, 25, 25];
vz2 = [10, 10, 10, 10];
vK = [1000,15000,10000,15000];

for jj = 1:length(vz2)
            figure
            K = vK(jj);
            z1 = vz1(jj);
            z2 = vz2(jj);
            Kd = K*M/(600*Kt*omega_0);
            Kp = Kd*(z1 + z2);
            Ki = Kd*z1*z2;
            s = tf('s');
            G_open = (s + z1) * ( s + z2)/ (s^3*(s+300));
            rlocus(G_open);
            title(sprintf('z1 = %.1f  z2 = %.1f',z1,z2));
            snapnow;
            close all
            StopTime = 10;
            Zref = 1;
            simOut = sim("sim_session6_2023.slx");
            figure;
            plot(simOut.dz.time,simOut.dz.signals.values); 
            title(sprintf("Step response of PID controller for z1=%.1f," + ...
                " z2=%.1f and K = %.1f",z1,z2,K));
            maxh=max(simOut.dz.signals.values);
            xlabel('time(s)');
            ylabel('z(m)');
            snapnow;
            close all
end
%%
%As expected, systems with positive zeros are generally stable given the
%analysis of the Rootlocus, The value of K can be increased to help
%stabilize the system and reduce the overshoot

%% Session 7
 
%% Inicializations
 
Wd = 50*2*pi/60;
% Q5.4 Effect of disturbances with the PD controller 
 
 Zref = 1;
 StopTime = 100;
 for K = [50 100 500 2000 15000]
    Kd = K*M/(600*Kt*omega_0);
    Kp = Kd*(Zref);
    simOut = sim("sim_session7_PD.slx");
    figure;
    plot(simOut.dz.time,simOut.dz.signals.values); 
    title(sprintf("PD Controller with K = %d",K));
    xlabel('time(s)');
    ylabel('z(m)');
 end
%% 
%  As expected the higher the gain the better the disturbance rejection for
%  a continue disturbance. We can observe that the tracking error is never
%  zero even for higher gains.
 
%% Q5.6 Effect of disturbances with the PID controller
 
Zref = 1;
StopTime = 25;
z1 = 1;
z2 = 10;
for K = [500 750 1000 2000 15000]
    Kd = K*M/(600*Kt*omega_0);
    Kp = Kd*(z1 + z2);
    Ki = Kd*z1*z2;
    simOut = sim("sim_session7_PID.slx");
    figure;
    plot(simOut.dz.time,simOut.dz.signals.values); 
    title(sprintf("PID Controller with K = %d",K));
    xlabel('time(s)');
    ylabel('z(m)');
end
 
%% 
% Analogue to exercise Q5.3, the disturbance rejection increases for higher 
% gains but with the PID the system need more time to be stabilized and
% higher gains. We could see that the same gain can produce a stable system
% with a PD controller and a unstable system with a PID controller. The
% system with the PID controller achieve tracking error zero in every
% stable case when time approaches to infinite.

