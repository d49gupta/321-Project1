clear; clc; close all;

% Knownn values
r2 = 5/100;
r3 = 16/100;
r6 = 8/100;
theta2_vel = 135*6;
phi = 14.931;

% Iterate through theta2 to calculate values of all dependant variables
for theta2_pos = 0:1:360
theta3_pos = asind((-r2/r3).*sind(theta2_pos));
theta3_pos = theta3_pos - 180; % True value of theta 3
r1_pos = r2.*cosd(theta2_pos) + r3.*cosd(theta3_pos); 
theta6_pos = asind((-15*sind(theta3_pos) + 4*cosd(theta3_pos) + r2*sind(theta3_pos - theta2_pos))/r6) + theta3_pos;
theta6_pos = abs(theta6_pos + 180); % True value of theta 6
% No need for r5 since slider will always be connected to r6*theta6

% Loop 1 
X = [0 r2.*cosd(theta2_pos) r1_pos];
Y = [0 r2.*sind(theta2_pos) 0];

% Loop 2
X1 = [-15 (-15 + r6*cosd(theta6_pos)) r2.*cosd(theta2_pos) 0];
Y1 = [-4 (-4 + r6*sind(theta6_pos)) r2.*sind(theta2_pos) 0];

% Open figure and plot 'o' at key points in mechanism
figure(1)
plot(0, 0, 'o')
plot(r2.*cosd(theta2_pos), r2.*sind(theta2_pos), 'o')
plot (r1_pos, 0, 'o')
plot(-15, -4, 'o')
plot(-15 + r6.*cosd(theta6_pos), -4 + r6.*sind(theta6_pos), 'o')
hold on

% Plot loops and set axes restrictions
plot(X, Y, 'r');
plot(X1, Y1, 'b');
axis equal
axis([-25 10 -10 10])
hold off

end