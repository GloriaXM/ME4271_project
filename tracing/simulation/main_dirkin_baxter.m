clear all
clc;
close all

q = [0; 0; 0; 0; 0; 0; 0];

xf = [-0.5; 0.5; 0.5];
th_f = euler_angles(xf,xf+xf)

T = 5;  % simulation time [sec]
FR = 10; % frame rate [Hz]

%% Setup simulation visualizer object
fig_handle=figure(1);
axis equal;
axis([-1.5,1.5,-1.5,1.5,-0.1,1.5]);
xlabel("X"); ylabel("Y"); zlabel("Z");
baxter = SimulationVisualizer(fig_handle);

%% setup poses
poses = [];
for t=0:(1/FR):T
    baxter.setJointAngles(q); % set joint angles 
    baxter.plotRobot(); % update plot
    
    % Print ee position
    frames = baxter.getFrames();

    %% Calculate Jacobian
    o0 = [0 0 0]'; z0 = [0 0 1]';
    for i=1:1:size(frames,3)
        eval(['o',num2str(i),'=frames(1:3,4,',num2str(i),');']);
        eval(['z',num2str(i),'=frames(1:3,3,',num2str(i),');']);
    end

    if t == 0
        xi = o7;
        th_i = euler_angles(o7,o7+o7)
    end

    for i=1:1:size(frames,3)
        eval(['J',num2str(i),'=[(X(o',num2str(i-1),'-o7)*z',num2str(i-1),')'' z',num2str(i-1),''']'';']);
    end
    
    J = [J1 J2 J3 J4 J5 J6 J7];

    %% Quintic to Target with Pose Interpolation
    eta = t/T;
    x_dot = (xf-xi)*(30*eta^2 - 60*eta^3 + 30*eta^4)/T;
    omega = (th_f-th_i)*(30*eta^2 - 60*eta^3 + 30*eta^4)/T;

    % R = extract_R(frames(:,:,7));
    % q1 = real(0.5*sqrt(1+R(1,1)+R(2,2)+R(3,3)))
    % q2 = real(0.5*sign(R(3,2)-R(2,3))*sqrt(1+R(1,1)-R(2,2)-R(3,3)))
    % q3 = real(0.5*sign(R(1,3)-R(3,1))*sqrt(1-R(1,1)+R(2,2)-R(3,3)))
    % q4 = real(0.5*sign(R(2,1)-R(1,2))*sqrt(1-R(1,1)-R(2,2)+R(3,3)))
    %eulZYX = quat2eul([q1 q2 q3 q4])
    %break
    
    x_cur = o7;
    twist = [x_dot; omega];
    q_dot = pinv(J)*twist;
    q = q + (1/FR)*q_dot;

    %% Pace to Target
    % eta = t/T
    % x_dot = (xf-xi)/T
    % twist = [x_dot' 0 0 0]';
    % q_dot = pinv(J)*twist
    % q = q + (1/FR)*q_dot;

    %% Draw Target
    [x,y,z] = sphere(8);
    r = 0.1;
    RedBall = surf(r*x+xf(1),r*y+xf(2),r*z+xf(3));
    set(RedBall, 'FaceColor', [1 0 0], 'FaceAlpha', 1)

    % Pause so you can see the visualization
    pause(1/FR);

end