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

% Known/Symbolic Angles
syms theta2_pos;
theta2_vel = 135*6;
phi = 14.931;

% Functions
theta3_pos = asind((-r2/r3)*sind(theta2_pos)) + 180;
theta3_vel = -r2*theta2_vel*cosd(theta2_pos)/(r3*cosd(theta3_pos));
theta3_acc = (r2*(theta2_vel^2)*sind(theta2_pos) + r3*(theta3_vel^2)*sind(theta3_pos))/(r3*cosd(theta3_pos));

r1_pos = (r2*cosd(theta2_pos) + r3*cosd(theta3_pos));
r1_vel = (-r2*theta2_vel*sind(theta2_pos) - r3*theta3_vel*sind(theta3_pos));
r1_acc = (-r2*(theta2_vel^2)*cosd(theta2_pos) - r3*(theta3_acc*sind(theta3_pos) + (theta3_vel^2)*cosd(theta3_pos)));

x = (-15*sind(theta3_pos) + 4*cosd(theta3_pos) + r2*sind(theta3_pos - theta2_pos))/r6; % Negative here?
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
A = [1	0	0	1	0	0	0	0	0	0	0	0	0	0  0;
    0	-1	0	0	1	0	0	0	0	0	0	0	0	0	0;
    0	0	1	A44	A45	0	0	0	0	0	0	0	0	0	0;
    0	0	0	1	0	1	0	0	0	1	0	0	0	0	0;
    0	0	0	0	-1	0	-1	0	0	0	-1	0	0	0	0;
    0	0	0	A64	A65	A66	A67	0	0	A610	A611	0	0	0	0;
    0	0	0	0	0	1	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	1	0	1	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	1	0	0	0	1	0;
    0	0	0	0	0	0	0	0	0	0	1	0	0	0	1;
    0	0	0	0	0	0	0	0	0	A1210	-1	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	-1	0	1	0;
    0	0	0	0	0	0	0	0	0	0	0	0	-1	0	1;
    0	0	0	0	0	0	0	0	0	0	0	0	0	A1514	A1515;
    ];

results = [m2*AG2X; 
            m2*AG2Y;
            0;
            m3*AG3X;
            m3*AG3Y;
            IG3*theta3_acc;
            m4*AG4X;
            0;
            m5*AG5X;
            m5*AG5Y;
            0;
            m6*AG6X;
            m6*AG6Y;
            (IG6-m6*(b6)^2)*theta6_acc;
    ];

forces = linsolve(A, results); % Solves all unknown joint forces and M12

% Shaking Force
% FSX = -F16X + F12X;
% FSY = -F16Y - F14Y - F12Y;
% FS = sqrt(FSX^2 + FSY^2);

% Shaking Moment
% SM = F14Y*r1_pos - 4*F16X + 15*F16Y + M12;

% Plot Forces
% theta2_deg = 0:1:360;
% for i = 1:length(forces)
%     subplot(3, 5, i); % 3x5 grid of subplots
%     force_values = arrayfun(forces{i}, theta2_rad); % Evaluate the ith force function over theta2
%     plot(theta2_deg, force_values); % Plot force as a function of theta2 in degrees
%     title(['Force ', num2str(i)]);
%     xlabel('Theta2 (degrees)');
%     ylabel('Force');
% end

