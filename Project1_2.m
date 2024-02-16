% Link Lengths
r2 = 5;
r3 = 16;
r6 = 8;
b2 = r2/2;
b3 = r3/3;
b6 = 4;

r5 = 0; % Placeholder
theta6 = 0; % Placeholder
theta6_vel = 0; % Placeholder
theta6_acc = 0; % Placeholder

% Known/Symbolic Angles
syms theta2_pos;
theta2_vel = 135*6;
theta3_pos= asind((-r2/r3)*sind(theta2_pos)) + 180;
theta3_vel = -r2*theta2_vel*cosd(theta2_pos)/(r3*cosd(theta3_pos));
theta3_acc = (r2*(theta2_vel^2)*sind(theta2_pos) + r3*(theta3_vel^2)*sind(theta3_pos))/(r3*cosd(theta3_pos));
phi = 14.931;

% Coefficients of Forces
A44 = -r2*sind(theta2_pos);
A45 = -r2*cosd(theta2_pos);
A66 = b3*sind(theta3_pos);
A67 = b3*cosd(theta3_pos);
A65 = -b3*cosd(theta3_pos);
A64 = -b3*sind(theta3_pos);
A610 = -(b3-r5)*cos(theta3_pos);
A611 = -(b3-r5)*sin(theta3_pos);
A1514 = -r6*sind(theta6+phi);
A1515 = r6*cosd(theta6+phi);

% Masses of Links (g)
m2 = 2.651;
m3 = 8.482;
m6 = 4.241;

% Acceleration and MOI
AG2X = -b2*(theta2_vel^2)*cosd(theta2_pos);
AG2Y = -b2*(theta2_vel^2)*sind(theta2_pos);
AG3X = -r2*(theta2_vel^2)*cosd(theta2_pos) - b3*theta3_acc*sind(theta3_pos) - b3*(theta3_vel^2)*cosd(theta3_pos);
AG3Y = -r2*(theta2_vel^2)*sind(theta2_pos) + b3*theta3_acc*cosd(theta3_pos) - b3*(theta3_vel^2)*sind(theta3_pos);
IG3 = (1/12)*m3*r3;
AG4X = r1_acc;
AG5X = -r6*theta6_acc*sind(theta6) - r6*(theta6_vel^2)*cosd(theta6) + r6*theta6_acc*cosd(theta6) - r6*(theta6_vel^2)*sind(theta6); % Need theta6 and their derivatives
AG6X = -b6*theta6_acc*sind(theta6) - b6*(theta6_vel^2)*cosd(theta6); % Need theta6 and their derivatives
AG6Y = b6*theta6_acc*cosd(theta6) - b6*(theta6_vel^2)*sind(theta6); % Need theta6 and their derivatives
IG6 = (1/12)*m6*r6;

A = [1	0	0	1	0	0	0	0	0	0	0	0	0	0  0;
    0	-1	0	0	1	0	0	0	0	0	0	0	0	0	0;
    0	0	1	A44	A45	0	0	0	0	0	0	0	0	0	0;
    0	0	0	1	0	1	0	0	0	1	0	0	0	0	0;
    0	0	0	0	-1	0	-1	0	0	0	-1	0	0	0	0;
    0	0	0	A64	A65	A66	A67	0	0	A610	A611	0	0	0	0;
    0	0	0	0	0	1	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	1	0	1	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	1	0	0	0	1	0;
    0	0	0	0	0	0	0	0	0	0	1	0	0	0	1;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	-1	0	1	0;
    0	0	0	0	0	0	0	0	0	0	0	0	-1	0	1;
    0	0	0	0	0	0	0	0	0	0	0	0	0	A1514	A1515;
    ];

forces = [F12x;
         F12y;
         M12;
         F23x;
         F23y
         F34x;
         F34y;
         F14x;
         F14y;
         F16x;
         F16y;
         F35x;
         F35y;
         F56x;
         F56y;
    ];

results = [m2*AG2X; 
            m2*AG2Y;
            0;
            m3*AG3X;
            m3*AG3Y;
            IG3*theta3_acc;
            m4*AG4X;
            0;
            0;
            m5*AG5X;
            m5*AG5Y;
            0;
            m6*AG6X;
            m6*AG6Y;
            (IG6+m6*(b6)^2)*theta6_acc;
    ];

disp(A);
forces = linsolve(A, results);