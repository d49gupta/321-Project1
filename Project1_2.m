% Link Lengths
r2 = 5;
r3 = 16;
r6 = 8;
b2 = r2/2;
b3 = r3/3;
b6 = 4;

% Masses of Links and sliders (g)
m2 = 2.651;
m3 = 8.482;
m4 = 5;
m5 = 5;
m6 = 4.241;

% Known/Independant Angles
theta2_range = linspace(0, 720, 720); % From 0 to 360 degrees with 1-degree step
theta2_vel = 135*6;
phi = 14.931;

% Create empty lists for all results to graph later
F12X = zeros(1, length(theta2_range));
F12Y = zeros(1, length(theta2_range));
M12 = zeros(1, length(theta2_range));
F23X = zeros(1, length(theta2_range));
F23Y = zeros(1, length(theta2_range));
F34X = zeros(1, length(theta2_range));
F34Y = zeros(1, length(theta2_range));
F14Y = zeros(1, length(theta2_range));
F35X = zeros(1, length(theta2_range));
F35Y = zeros(1, length(theta2_range));
F16X = zeros(1, length(theta2_range));
F16Y = zeros(1, length(theta2_range));
F56X = zeros(1, length(theta2_range));
F56Y = zeros(1, length(theta2_range));
SF = zeros(1, length(theta2_range));
SM = zeros(1, length(theta2_range));

for i = 1:length(theta2_range)
    theta2_pos = theta2_range(i);
    % Functions
    theta3_pos = asind((-r2/r3)*sind(theta2_pos)) + 180;
    theta3_vel = -r2*theta2_vel*cosd(theta2_pos)/(r3*cosd(theta3_pos));
    theta3_acc = (r2*(theta2_vel^2)*sind(theta2_pos) + r3*(theta3_vel^2)*sind(theta3_pos))/(r3*cosd(theta3_pos));
    
    r1_pos = (r2*cosd(theta2_pos) + r3*cosd(theta3_pos));
    r1_vel = (-r2*theta2_vel*sind(theta2_pos) - r3*theta3_vel*sind(theta3_pos));
    r1_acc = (-r2*(theta2_vel^2)*cosd(theta2_pos) - r3*(theta3_acc*sind(theta3_pos) + (theta3_vel^2)*cosd(theta3_pos)));
    
    x = (-15*sind(theta3_pos) + 4*cosd(theta3_pos) + r2*sind(theta3_pos - theta2_pos))/r6; 
    theta6 = asind((-15*sind(theta3_pos) + 4*cosd(theta3_pos) + r2*sind(theta3_pos - theta2_pos))/r6) + theta3_pos;
    theta6 = abs(theta6 + 180);
    theta6_vel = 1/(sqrt(x^2 - 1)) + theta3_vel; % Is this how I do it?
    theta6_acc = x*(-15*theta3_vel*cosd(theta3_pos) - 4*theta3_vel*sind(theta3_pos) + (theta3_vel - theta2_vel)*r2*cos(theta3_pos - theta2_pos))/(r6*((1-x))^1.5) + theta3_acc;
    
    r5 = 15*cosd(theta3_pos) + 4*sind(theta3_pos) + r6*cosd(theta6 - theta3_pos) - r2*cosd(theta2_pos + theta3_pos);
    r5_vel = -15*theta3_vel*sind(theta3_pos) + 4*theta3_vel*cosd(theta3_pos) - (theta6_vel - theta3_vel)*r6*sind(theta6 - theta3_pos) + (theta2_vel + theta3_vel)*r2*sind(theta2_pos + theta3_pos);
    r5_acc = -15*theta3_acc*sind(theta3_pos) - 15*(theta3_vel^2)*cosd(theta3_pos) + 4*theta3_acc*cosd(theta3_pos) - 4*(theta3_vel^2)*sind(theta3_pos) - (theta6_acc - theta3_acc)*r6*sind(theta6 - theta3_pos) - ((theta6_vel - theta3_vel)^2)*r6*cosd(theta6 - theta3_pos) + theta3_acc*r2*sind(theta2_pos + theta3_pos) + ((theta2_vel + theta3_vel)^2)*r2*cosd(theta2_pos + theta3_pos);
    
    % Coefficients of Forces
    A44 = -r2*sind(theta2_pos);
    A45 = -r2*cosd(theta2_pos);
    A66 = b3*sind(theta3_pos);
    A67 = b3*cosd(theta3_pos);
    A65 = -b3*cosd(theta3_pos);
    A64 = -b3*sind(theta3_pos);
    A610 = -(b3-r5)*cos(theta3_pos);
    A611 = -(b3-r5)*sin(theta3_pos);
    A1210 = tand(theta3_pos);
    A1514 = -r6*sind(theta6+phi);
    A1515 = r6*cosd(theta6+phi);
    
    % Acceleration and MOI
    AG2X = -b2*(theta2_vel^2)*cosd(theta2_pos);
    AG2Y = -b2*(theta2_vel^2)*sind(theta2_pos);
    AG3X = -r2*(theta2_vel^2)*cosd(theta2_pos) - b3*theta3_acc*sind(theta3_pos) - b3*(theta3_vel^2)*cosd(theta3_pos);
    AG3Y = -r2*(theta2_vel^2)*sind(theta2_pos) + b3*theta3_acc*cosd(theta3_pos) - b3*(theta3_vel^2)*sind(theta3_pos);
    IG3 = (1/12)*m3*r3;
    AG4X = r1_acc;
    AG5X = -r6*theta6_acc*sind(theta6) - r6*(theta6_vel^2)*cosd(theta6); % Need theta6 and their derivatives
    AG5Y = r6*theta6_acc*cosd(theta6) - r6*(theta6_vel^2)*sind(theta6); % Need theta6 and their derivatives
    AG6X = -b6*theta6_acc*sind(theta6) - b6*(theta6_vel^2)*cosd(theta6); % Need theta6 and their derivatives
    AG6Y = b6*theta6_acc*cosd(theta6) - b6*(theta6_vel^2)*sind(theta6); % Need theta6 and their derivatives
    IG6 = (1/12)*m6*r6;
    
    % Matrix
    A = [1	0	0	1	0	0	0	0	0	0	0	0	0  0;
        0	-1	0	0	1	0	0	0	0	0	0	0	0	0;
        0	0	1	A44	A45	0	0	0	0	0	0	0	0	0;
        0	0	0	1	0	1	0	0	1	0	0	0	0	0;
        0	0	0	0	-1	0	-1	0	0	-1	0	0	0	0;
        0	0	0	A64	A65	A66	A67	0	A610	A611	0	0	0	0;
        0	0	0	0	0	1	0	0	0	0	0	0	0	0;
        0	0	0	0	0	0	1	1	0	0	0	0	0	0;
        0	0	0	0	0	0	0	0	1	0	0	0	1	0;
        0	0	0	0	0	0	0	0	0	1	0	0	0	1;
        0	0	0	0	0	0	0	0	A1210	-1	0	0	0	0;
        0	0	0	0	0	0	0	0	0	0	-1	0	1	0;
        0	0	0	0	0	0	0	0	0	0	0	-1	0	1;
        0	0	0	0	0	0	0	0	0	0	0	0	A1514	A1515;
        ];
    
    results = [m2.*AG2X; 
                m2.*AG2Y;
                0;
                m3.*AG3X;
                m3.*AG3Y;
                IG3.*theta3_acc;
                m4.*AG4X;
                0;
                m5.*AG5X;
                m5.*AG5Y;
                0;
                m6.*AG6X;
                m6.*AG6Y;
                (IG6-m6.*(b6).^2).*theta6_acc;
        ];
    
    forces = linsolve(A, results); % Solves all unknown joint forces and M12
    
    % Defining joint forces based off matrix results
    F12X(i) = abs(forces(1));
    F12Y(i) = abs(forces(2));
    M12(i) = abs(forces(3));
    F23X(i) = abs(forces(4));
    F23Y(i) = abs(forces(5));
    F34X(i) = abs(forces(6));
    F34Y(i) = abs(forces(7));
    F14Y(i) = abs(forces(8));
    F35X(i) = abs(forces(9));
    F35Y(i) = abs(forces(10));
    F16X(i) = abs(forces(11));
    F16Y(i) = abs(forces(12));
    F56X(i) = abs(forces(13));
    F56Y(i) = abs(forces(14));
    
    % Shaking Force
    FSX = -F16X(i) + F12X(i);
    FSY = -F16Y(i) - F14Y(i) - F12Y(i);
    shaking_force = abs(sqrt(FSX.^2 + FSY.^2));
    
    % Shaking Moment
    shaking_moment = abs(F14Y(i).*r1_pos - 4.*F16X(i) + 15.*F16Y(i) + M12(i));

    SF(i) = shaking_force;
    SM(i) = shaking_moment;
end


%Plotting Internal Forces
figure;
subplot(4, 4, 1);
plot(theta2_range, F12X);
xlabel('Theta2');
ylabel('F12x');
title('Internal F12x Forces');
grid on;

subplot(4, 4, 2);
plot(theta2_range, F12Y);
xlabel('Theta2');
ylabel('F12y');
title('Internal F12y Forces');
grid on;

subplot(4, 4, 3);
plot(theta2_range, F23X);
xlabel('Theta2');
ylabel('F23x');
title('Internal F23x Forces');
grid on;

subplot(4, 4, 4);
plot(theta2_range, F23Y);
xlabel('Theta2');
ylabel('F23y');
title('Internal F23y Forces');
grid on;

subplot(4, 4, 5);
plot(theta2_range, F34X);
xlabel('Theta2');
ylabel('F34x');
title('Internal F34x Forces');
grid on;

subplot(4, 4, 6);
plot(theta2_range, F34Y);
xlabel('Theta2');
ylabel('F34y');
title('Internal F34y Forces');
grid on;

subplot(4, 4, 7);
plot(theta2_range, F14Y);
xlabel('Theta2');
ylabel('F14y');
title('Internal F14y Forces');
grid on;

subplot(4, 4, 8);
plot(theta2_range, F16X);
xlabel('Theta2');
ylabel('F16x');
title('Internal F16x Forces');
grid on;

subplot(4, 4, 9);
plot(theta2_range, F16Y);
xlabel('Theta2');
ylabel('F16y');
title('Internal F16y Forces');
grid on;

subplot(4, 4, 10);
plot(theta2_range, F35X);
xlabel('Theta2');
ylabel('F35x');
title('Internal F35x Forces');
grid on;

subplot(4, 4, 11);
plot(theta2_range, F35Y);
xlabel('Theta2');
ylabel('F35y');
title('Internal F35y Forces');
grid on;

subplot(4, 4, 12);
plot(theta2_range, F56X);
xlabel('Theta2');
ylabel('F56x');
title('Internal F56x Forces');
grid on;

subplot(4, 4, 13);
plot(theta2_range, F56Y);
xlabel('Theta2');
ylabel('F56y');
title('Internal F56y Forces');
grid on;

subplot(4, 4, 14);
plot(theta2_range, M12);
xlabel('Theta2');
ylabel('Moment M12');
title('M12 wrt Theta2');
grid on;

subplot(4, 4, 15);
plot(theta2_range, SF);
xlabel('Theta2');
ylabel('Shaking Force');
title('Shaking Force');
grid on;

subplot(4, 4, 16);
plot(theta2_range, SF);
xlabel('Theta2');
ylabel('Shaking Moment');
title('Shaking Moment');
grid on;
