function y = pendulum_dynamics(x,u)
%% pendulum_dynamics: calculate pendulum dynamics
  
  % === states and controls:
  % x = [phi dphi]' = [angle; angular velocity]
  % u = [F]'     = [force applied]

%% ******** Owner of Code ************************************************
  % Krunalkumar, Zadafiya (TU Kaiserslautern)
  %
  % Author: zadafiya@rhrk.uni-kl.de
  % **********************************************************************
  % Begin initializataion code - DO NOT EDIT

% constants
l  = 0.5;      % l = length of pendulum
h  = 0.01;     % h = timestep (seconds)
m = 1;         % m = mass in Kg
b = 1;         % damping coefficient
g = 9.81;      % gravitational acceleration in m/s^2

% controls
F  = u(1,:,:);      % F = force applied tangetially

phi  = x(1,:,:);    % phi = angel w.r.t. verticle axis
dphi = x(2,:,:);    % dphi = angular velocity

z  = [u* 0 + dphi; F/(m*l) - b*dphi/(m*l) - g*sin(phi)/l]; %linear system

dy = h*z;           % change in state
y  = x + dy;        % new state
end