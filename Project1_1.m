% Known link lengths
r2 = 5/100;
r3 = 16/100;
r6 = 8/100;

% Theta2 (independent variable and its contant velocity)
syms theta2_pos;
theta2_vel = 135*6;

% Derived functions (_pos -> position, _vel -> velocity, _acc -> acceleration)
% Theta 3
theta3_pos = asind((-r2/r3)*sind(theta2_pos));
theta3_pos = theta3_pos + 180; % True value of theta3
theta3_vel = -r2*theta2_vel*cosd(theta2_pos)/(r3*cosd(theta3_pos));
theta3_acc = (r2*(theta2_vel^2)*sind(theta2_pos) + r3*(theta3_vel^2)*sind(theta3_pos))/(r3*cosd(theta3_pos));

% r1
r1_pos = (r2*cosd(theta2_pos) + r3*cosd(theta3_pos));
r1_vel = (-r2*theta2_vel*sind(theta2_pos) - r3*theta3_vel*sind(theta3_pos));
r1_acc = (-r2*(theta2_vel^2)*cosd(theta2_pos) - r3*(theta3_acc*sind(theta3_pos) + (theta3_vel^2)*cosd(theta3_pos)));

% Theta 6
x = (-15*sind(theta3_pos) + 4*cosd(theta3_pos) + r2*sind(theta3_pos - theta2_pos))/r6;
theta6_pos = asind((-15*sind(theta3_pos) + 4*cosd(theta3_pos) + r2*sind(theta3_pos - theta2_pos))/r6) + theta3_pos;
theta6_pos = abs(theta6_pos + 180); % True value of theta6
theta6_vel = 1/(sqrt(x^2 - 1)) + theta3_vel; % Is this how I do it?
theta6_acc = x*(-15*theta3_vel*cosd(theta3_pos) - 4*theta3_vel*sind(theta3_pos) + (theta3_vel - theta2_vel)*r2*cos(theta3_pos - theta2_pos))/(r6*((1-x))^1.5) + theta3_acc;

% r5
r5_pos = 15*cosd(theta3_pos) + 4*sind(theta3_pos) + r6*cosd(theta6_pos - theta3_pos) - r2*cosd(theta2_pos + theta3_pos);
r5_vel = -15*theta3_vel*sind(theta3_pos) + 4*theta3_vel*cosd(theta3_pos) - (theta6_vel - theta3_vel)*r6*sind(theta6_pos - theta3_pos) + (theta2_vel + theta3_vel)*r2*sind(theta2_pos + theta3_pos);
r5_acc = -15*theta3_acc*sind(theta3_pos) - 15*(theta3_vel^2)*cosd(theta3_pos) + 4*theta3_acc*cosd(theta3_pos) - 4*(theta3_vel^2)*sind(theta3_pos) - (theta6_acc - theta3_acc)*r6*sind(theta6_pos - theta3_pos) - ((theta6_vel - theta3_vel)^2)*r6*cosd(theta6_pos - theta3_pos) + theta3_acc*r2*sind(theta2_pos + theta3_pos) + ((theta2_vel + theta3_vel)^2)*r2*cosd(theta2_pos + theta3_pos);

% Plot all 12 graphs
theta2_range = [0, 360]; % Range of theta2 (1 full revolution)
subplot(4, 3, 1);
fplot(theta3_pos, theta2_range);
xlabel('Theta2');
ylabel('Theta3');
title('Position of Theta3');
grid on;

subplot(4, 3, 2);
fplot(theta3_vel, theta2_range);
xlabel('Theta2');
ylabel('Theta3');
title('Velocity of Theta3');
grid on;

subplot(4, 3, 3);
fplot(theta3_acc, theta2_range);
xlabel('Theta2');
ylabel('Theta3');
title('Acceleration of Theta3');
grid on;

subplot(4, 3, 4);
fplot(r1_pos, theta2_range);
xlabel('Theta2');
ylabel('r1');
title('Position of r1');
grid on;

subplot(4, 3, 5);
fplot(r1_vel, theta2_range);
xlabel('Theta2');
ylabel('r1');
title('Velocity of r1');
grid on;

subplot(4, 3, 6);
fplot(r1_acc, theta2_range);
xlabel('Theta2');
ylabel('r1');
title('Acceleration of r1');
grid on;

subplot(4, 3, 7);
fplot(theta6_pos, theta2_range);
xlabel('Theta2');
ylabel('Theta 6');
title('Position of Theta6');
grid on;

subplot(4, 3, 8);
fplot(theta6_vel, theta2_range);
xlabel('Theta2');
ylabel('Theta 6');
title('Velocity of Theta6');
grid on;

subplot(4, 3, 9);
fplot(theta6_acc, theta2_range);
xlabel('Theta2');
ylabel('Theta 6');
title('Acceleration of Theta6');
grid on;

subplot(4, 3, 10);
fplot(r5_pos, theta2_range);
xlabel('Theta2');
ylabel('r5');
title('Position of r5');
grid on;

subplot(4, 3, 11);
fplot(r5_vel, theta2_range);
xlabel('Theta2');
ylabel('r5');
title('Velocity of r5');
grid on;

subplot(4, 3, 12);
fplot(r5_acc, theta2_range);
xlabel('Theta2');
ylabel('r5');
title('Acceleration of r5');
grid on;