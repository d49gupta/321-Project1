clear; clc; close all;

r2 = 5;
r3 = 16;
r6 = 8;
theta2_vel = 135*6;
phi = 14.931;

for theta2_pos = 0:1:720
theta3_pos = asind((-r2/r3).*sind(theta2_pos));
theta3_pos = theta3_pos + 180;
r1_pos = r2.*cosd(theta2_pos) + r3.*cosd(theta3_pos); 

theta6_pos = asind((r2*asind(theta2_pos - theta3_pos)-4*sind(theta3_pos) + r1_pos*cosd(theta3_pos))/r6) + theta3_pos;
r5 = (r1_pos - r6.*sind(theta6_pos) - r2.*sind(theta2_pos))/sind(theta3_pos);


% theta6_pos = asind((-r1_pos.*(cosd(theta3_pos) - sind(theta3_pos)) - r2.*sind(theta3_pos - theta2_pos))/r6) - theta3_pos;
% r5 = (r1_pos - r6.*sind(theta6_pos) - r2.*sind(theta2_pos))/sind(theta3_pos);

% theta6_pos = asind((cosd(theta3_pos)*(r1_pos*sind(phi) + r2*sin(theta2_pos)) - sind(theta3_pos)*(r1_pos*cosd(phi) + r2*cosd(theta2_pos)))/r6) + theta3_pos;
% r5 = (sind(theta6_pos)*(r1_pos*cosd(phi) + r2*cosd(theta2_pos)) - cosd(theta6_pos)*(r1_pos*sind(phi) + r2*sind(theta2_pos)))/sind(theta3_pos - theta6_pos);

figure(1)
plot(0, 0, 'o')
hold on

X = [0 r2.*cosd(theta2_pos) r1_pos];
Y = [0 r2.*sind(theta2_pos) 0];

X1 = [0 r2.*cosd(theta2_pos) r5.*cosd(theta3_pos) -15];
Y1 = [0 r2.*sind(theta2_pos) r5.*sind(theta3_pos) -4];

plot(r2.*cosd(theta2_pos), r2.*sind(theta2_pos), 'o')
plot (r1_pos, 0, 'o')
plot(r5.*cosd(theta3_pos), r5.*sind(theta3_pos), 'o')
plot(-15, -4, 'o')
hold on

plot(X, Y, 'r');
plot(X1, Y1, 'b');
axis equal
axis([-25 10 -10 10])
hold off

end