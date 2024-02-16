r2 = 5/100;
r3 = 16/100;

syms theta2_pos;
theta2_vel = 135*6;

theta3_pos= asind((-r2/r3)*sind(theta2_pos));
theta3_pos = theta3_pos + 180;
theta3_vel = -r2*theta2_vel*cosd(theta2_pos)/(r3*cosd(theta3_pos));
theta3_acc = (r2*(theta2_vel^2)*sind(theta2_pos) + r3*(theta3_vel^2)*sind(theta3_pos))/(r3*cosd(theta3_pos));

% Switch signs of r3
r1_pos = (r2*cosd(theta2_pos) + r3*cosd(theta3_pos));
r1_vel = (-r2*theta2_vel*sind(theta2_pos) - r3*theta3_vel*sind(theta3_pos));
r1_acc = (-r2*(theta2_vel^2)*cosd(theta2_pos) - r3*(theta3_acc*sind(theta3_pos) + (theta3_vel^2)*cosd(theta3_pos)));

theta2_range = [0, 720];
subplot(2, 3, 1);
fplot(theta3_pos, theta2_range);
xlabel('Theta2');
ylabel('Theta3');
title('Position of Theta3');
grid on;

subplot(2, 3, 2);
fplot(theta3_vel, theta2_range);
xlabel('Theta2');
ylabel('Theta3');
title('Velocity of Theta3');
grid on;

subplot(2, 3, 3);
fplot(theta3_acc, theta2_range);
xlabel('Theta2');
ylabel('Theta3');
title('Acceleration of Theta3');
grid on;

subplot(2, 3, 4);
fplot(r1_pos, theta2_range);
xlabel('Theta2');
ylabel('r1');
title('Position of r1');
grid on;

subplot(2, 3, 5);
fplot(r1_vel, theta2_range);
xlabel('Theta2');
ylabel('r1');
title('Velocity of r1');
grid on;

subplot(2, 3, 6);
fplot(r1_acc, theta2_range);
xlabel('Theta2');
ylabel('r1');
title('Acceleration of r1');
grid on;