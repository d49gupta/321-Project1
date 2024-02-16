clear; clc; close all;

% Given lengths in cm
r_O2A = 5.0;
r_AC = 16.0;
r_O6B6 = 8.0;

% Convert lengths to meters for plotting
r_O2A = r_O2A / 100;
r_AC = r_AC / 100;
r_O6B6 = r_O6B6 / 100;

% Initialize figure
figure(1);
axis equal;
axis([-0.25 0.25 -0.25 0.25]); % Set axis limits
hold on;
grid on;

% Define the fixed pivot point O2
O2 = [0, 0];

% Loop for a full rotation of link 2
for theta2_pos = 0:1:360
    % Calculate the position of A
    A = O2 + r_O2A * [cosd(theta2_pos), sind(theta2_pos)];
    
    % Since link 3 (AC) is horizontal, C has the same y-coordinate as A
    C = [A(1) + r_AC, A(2)];
    
    % The end of link 6 (B6) is vertically above C by distance r_O6B6
    B6 = [C(1), C(2) + r_O6B6];
    
    % Clear the previous plot and re-plot the mechanism
    clf;
    plot([O2(1) A(1)], [O2(2) A(2)], 'b', 'LineWidth', 2); % Link O2A
    plot([A(1) C(1)], [A(2) C(2)], 'r', 'LineWidth', 2); % Link AC
    plot([C(1) B6(1)], [C(2) B6(2)], 'g', 'LineWidth', 2); % Link CB6
    plot(O2(1), O2(2), 'ko', 'MarkerFaceColor', 'k'); % Pivot O2
    plot(A(1), A(2), 'ko', 'MarkerFaceColor', 'b'); % Joint A
    plot(C(1), C(2), 'ko', 'MarkerFaceColor', 'r'); % Joint C
    plot(B6(1), B6(2), 'ko', 'MarkerFaceColor', 'g'); % Joint B6
    
    % Update the plot
    drawnow;
    
    % Pause to control the speed of the animation
    pause(0.01);
end
