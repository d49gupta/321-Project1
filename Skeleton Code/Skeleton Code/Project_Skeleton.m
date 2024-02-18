%% Project Skeleton Code

clear; clc; close all;

%%initial parameter: unit: cm, degree, rad/sec
r4 = 16; %cm AC
r6 = 8; % cm  O6B6


% and so on ...

theta_2 = 0:1:720; % from 0 to 360 with step 1: [0,1,2,3,4....360]


% TIPS:  

% cosd(x) - is a cosine of x, where x in degrees
% cos(x) - is a cosine of x, where x in radians
% using '.*' enables element-wise multiplication
% accordingly, '.^' element-wise exponent
% [a1 a2 a3].^[b1 b2 b3] = [a1*b1 a2*b2 a3*b3]
% '*' is matrix multiplication

%% Part 1- Calculations for kinematic variables, caculated based on loop closure eqn

theta_i = % ENTER YOUR CODE HERE
% Hint: Check if the angle needs to be adjusted to its true value
% Hint: Check this for all other angles too
r_i = % ENTER YOUR CODE HERE



%% Take time derivative of loop eqn (d/dt) by hand 
% and solve them for dtheta_i & dr_i
% and the same for the second derivatives. 


%% Plot vars;

% Plot all desired deliverables. 
figure (1)
plot(theta_2,theta_i)
grid on;
title('$\theta_3$ vs $\theta_2$', 'Interpreter','latex')
xlabel('\theta_2   unit: degree')
ylabel('\theta_3   unit: degree')

% and so on

% *****************************************************

%% Part 2 - Force and Moment Calculation

%%initial parameter: unit: m, degree, rad/sec


dtheta_2 = (value); % theta2 dot = 135 rpm (dont forget to convert to rad/s)
ddtheta_2 = 0; % theta2 doble-dot - second derivative


m_i = % ENTER YOUR CODE HERE % ; % link 2, o2a2 kg
I_Gi = % ENTER YOUR CODE HERE %;
% and so on



M12_list = [];
theta2_list = [];
Fs_list = [];  % shaking force
Ms_list =[]; % Shaking moment
Fij_list = []; % Forces



for theta2 = 0:1:360

    % kinematic variables are caculated based on loop eqn
    r_i = % ENTER YOUR CODE HERE %;
    dr_i = % ENTER YOUR CODE HERE %;
    ddr_i = % ENTER YOUR CODE HERE %;

% and so on    

    B = get_ma_vector(%m_i, ... % these are the examples of the possible input
        % ri ... % Only include the inputs that are necessary
        % theta_i ...
        % dtheta_i ...
        % and so on);
    
    A = get_A_matrix(%m_i, ... % these are the examples of the possible input
        % ri ... % Only include the inputs that are necessary
        % theta_i ...
        % dtheta_i ...
        % ddtheta_i ...
        % and so on);

    x = A\ B; % Ax = B, solution for x; note that in MATLAB: A\B = B/A
    
    % M12:
    M12 = x(% ENTER YOUR CODE HERE%);
    M12_list = [M12_list; M12];
    
    Fijx = x(% ENTER YOUR CODE HERE%);
    Fijy = x(% ENTER YOUR CODE HERE%);
    
    % Magnitudes of all forces: 

    Fij_list = [Fij_list; % ENTER YOUR CODE HERE%];

    
  
    % Collecting the values of theta2:
    theta2_list = [theta2_list, theta_2];
     
   
    
end


% Force and Moment plots:

figure (3)
plot(theta2_list,M12_list)
grid on;
title('M_{12} vs \theta_2')
xlabel('\theta_2   unit: degree')
ylabel('M12   unit: N-m')

% and so on ...

