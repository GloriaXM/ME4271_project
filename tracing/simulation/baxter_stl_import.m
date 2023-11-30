clear all;
clc;
%% Base
[p,t,tnorm]=STL_Import('Arm0.stl');                                % load stl file
base = 0.001*p;                                                            % convert mm to m 
T = [eye(3),[0;0;0];[0 0 0 1]];                                            % build tranformation matrix
base = T * [base,ones(size(base,1),1)]';                                   % transformation to put the base in the home configuration
save('baxter_Arm0_meters','base','t');                                    % save data file

%% Link 1
[p,t,tnorm]=STL_Import('Arm1.stl');                                 % load stl file
link1 = 0.001*p;                                                           % convert inch to m                                                                                         % translation of -0.1 meters along z
T1 = [eye(3),[0;0;0];[0 0 0 1]];                                           % build transformation matrix
link1 =T1*[link1,ones(size(link1,1),1)]';                                  % transformation to put link1 in the home configuration
save('baxter_Arm1_meters','link1','t');                                    % save data file

%% Link 2
[p,t,tnorm] = STL_Import('Arm2.stl');                               % load stl file
link2 = 0.001*p;                                                           % convert mm to m
T2 = [eye(3),[0;0;0];[0 0 0 1]];                                           % build trasformation  matrix 
link2 = T2 * [link2,ones(size(link2,1),1)]';                               % transformation to put link2 in the home configuration
save('baxter_Arm2_meters','link2','t');                                    % save data file

%% Link 3
[p,t,tnorm] = STL_Import('Arm3.stl');                             % load stl file
link3 = 0.001*p;                                                           % convert mm to m
T3 = [eye(3),[0;0;0];[0 0 0 1]];                                           % build tranformation matrix
link3 =  T3 * [link3,ones(size(link3,1),1)]';                              % transformation to put link3 in the home configuration
save('baxter_Arm3_meters','link3','t');                                  % save data file

%% Link 4
[p,t,tnorm]=STL_Import('Arm4.stl');                             % load stl file
link4 = 0.001*p;                                                           % convert inch to m
T4 = [eye(3),[0;0;0];[0 0 0 1]];                                           % buildt tranformation matrix
link4 = T4 * [link4,ones(size(p,1),1)]';                                   % transformation to put link4 in the home configuration
save('baxter_Arm4_meters','link4','t');                                  % save data file

%% Link 5
[p,t,tnorm]=STL_Import('Arm5.stl');                                % load stl file
link5 = 0.001*p;                                                           % convert inch to m                                                         
T5 = [eye(3),[0;0;0];[0 0 0 1]];                                           % buildt tranformation matrix
link5 = T5 * [link5,ones(size(p,1),1)]';                                   % transformation to put link5 in the home configuration
save('baxter_Arm5_meters','link5','t');                                  % save data file

%% Link 6
[p,t,tnorm]=STL_Import('Arm6.stl');                                   % load stl file
link6 = 0.001*p;                                                       % convert inch to m
R6 = eye(3);
T6 = [eye(3),[0;0;0];[0 0 0 1]];                                                % translation of 0.00508 m along z
link6 = T6 * [link6,ones(size(p,1),1)]';                                    % transformation to put link6 in the home configuration
save('baxter_Arm6_meters','link6','t');                                   % save data file
