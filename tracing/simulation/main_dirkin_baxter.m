clear all
clc;
close all

q = [0 0 0 0 0 0]';
xf = [0.5 -0.25 1]';
T = 5; % duration for tracking

for t = 0:0.1:T
    %% Calculate Direct Kinematics
    DH_matrix=set_DH_matrix(pi/180*q);
    Frames = direct_kinematics_using_DH(DH_matrix);
    
    %% Calculate Jacobian
    o0 = [0 0 0]'; z0 = [0 0 1]';
    for i=1:1:6
        eval(['o',num2str(i),'=Frames(1:3,4,',num2str(i),');']);
        eval(['z',num2str(i),'=Frames(1:3,3,',num2str(i),');']);
    end
    if t == 0
        xi = o6
    end
    
    for i=1:1:6
        eval(['J',num2str(i),'=[(X(o',num2str(i-1),'-o6)*z',num2str(i-1),')'' z',num2str(i-1),''']'';']);
    end
    J = [J1 J2 J3 J4 J5 J6];
    
    %% Quintic to Target
    % eta = t/T
    % x_dot = (xf-xi)*(30*eta^2 - 60*eta^3 + 30*eta^4)/T;
    % twist = [x_dot' 0 0 0]';
    % q_dot = pinv(J)*twist;
    % q = q + (180/pi)*0.1*q_dot;

    %% Pace to Target
    % x_dot = (xf-xi)/T;
    % twist = [x_dot' 0 0 0]';
    % q_dot = pinv(J)*twist;
    % q = q + (180/pi)*0.1*q_dot;

    %% Proportional to Target
    eta = t/T
    x_dot = (xf-o6)*eta;
    twist = [x_dot' 0 0 0]';
    q_dot = pinv(J)*twist;
    q = q + (180/pi)*q_dot;

    %% Draw Robot
    draw_baxter(Frames)
    xlim([-1.5 1.5])
    ylim([-1.5 1.5])
    zlim([-1.5 2])

    [x,y,z] = sphere(8);
    r = 0.1;
    RedBall = surf(r*x+xf(1),r*y+xf(2),r*z+xf(3));
    set(RedBall, 'FaceColor', [1 0 0], 'FaceAlpha', 1)

    exportgraphics(gcf,'animation.gif','Append',true);
    clf reset;

end
