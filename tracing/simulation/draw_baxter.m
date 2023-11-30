%% Draw Meca500: this function draws the puma robot. 
% frames = 4:4:3 matrix containing the homogenous transpofrms for each 
% local link frame with respect to the ground
% example of use: 
%        DH_matrix=set_DH_matrix([0;0;0;0;0;0]) 
%        [frames] = direct_kinematics_using_DH(DH_matrix) 
%        draw_meca500(frames) 
% 
% first line defines the DH_matrix for a given q vector
% second line calculates the direct kinematics and returns a 3D 4x4x3 matrix with frames T01, T02,...T06
% third line draws the robot

%last updated 8/14/2012 by Nabil Simaan
%edited 10/01/2019 by Elan Ahronovich



%  
function draw_baxter(frames)

%% extracting all transformations T01, T02,...T06
for i=1:1:6
      eval(['T0',num2str(i),'= frames(:,:,',num2str(i),');']);
end;

%% Draw coordinate systems

figure(1);
grid on;
% draw_coordinate_system(0.2,eye(3),[0;0;0],['r' 'g' 'b'],'W');
% draw_coordinate_system(0.1,T01(1:3,1:3),T01(1:3,4),['r' 'g' 'b'],'1');
% draw_coordinate_system(0.15,T02(1:3,1:3),T02(1:3,4),['r' 'g' 'b'],'2');
% draw_coordinate_system(0.1,T03(1:3,1:3),T03(1:3,4),['r' 'g' 'b'],'3');
% draw_coordinate_system(0.15,T04(1:3,1:3),T04(1:3,4),['r' 'g' 'b'],'4');
% draw_coordinate_system(0.1,T05(1:3,1:3),T05(1:3,4),['r' 'g' 'b'],'5');
% draw_coordinate_system(0.1,T06(1:3,1:3),T06(1:3,4),['r' 'g' 'b'],'6');

%% Draw Link 0
load baxter_Arm0_meters; 
n = length(base(3,:));                                                      
C = ones(1,n)*0.5;
figure(1);
trisurf(t,base(1,:),base(2,:),base(3,:),C,'FaceColor',[0.3 0.3 0.3],'EdgeColor','none','FaceLighting','gouraud','EdgeLighting','phong','AmbientStrength', 0.5);

%% Draw Link 1                                
load baxter_Arm1_meters;
link1 = T01*link1;
n = length(link1(3,:));
C = ones(1,n)*0.5;
figure(1);
hold on;
trisurf(t,link1(1,:),link1(2,:),link1(3,:),C,'FaceColor',[1 0 0],'EdgeColor','none','FaceLighting','gouraud','EdgeLighting','phong','AmbientStrength', 0.5);

%% Draw Link 2
load baxter_Arm2_meters;
link2 = T02*link2;
n = length(link2(3,:));
C = ones(1,n)*0.5;
figure(1);
trisurf(t,link2(1,:),link2(2,:),link2(3,:),C,'FaceColor',[0 1 0],'EdgeColor','none','FaceLighting','gouraud','EdgeLighting','phong','AmbientStrength', 0.5);

%% Draw Link 3
load baxter_Arm3_meters;
link3 = T03*link3;
n = length(link3(3,:));
C = ones(1,n)*0.5;
figure(1);
trisurf(t,link3(1,:),link3(2,:),link3(3,:),C,'FaceColor',[255/255,153/255,102/255],'EdgeColor','none','FaceLighting','gouraud','EdgeLighting','phong','AmbientStrength', 0.5);

%% Draw Link 4
load baxter_Arm4_meters;
link4 = T04*link4;
n = length(link4(4,:));
C = ones(1,n)*0.5;
figure(1);
trisurf(t,link4(1,:),link4(2,:),link4(3,:),C,'FaceColor',[51/255,204/255,51/255],'EdgeColor','none','FaceLighting','gouraud','EdgeLighting','phong','AmbientStrength', 0.5);


%% Draw Link 5
load baxter_Arm5_meters;
link5 = T05*link5;
n = length(link5(4,:));
C = ones(1,n)*0.5;
figure(1);
trisurf(t,link5(1,:),link5(2,:),link5(3,:),C,'FaceColor',[1,0,0],'EdgeColor','none','FaceLighting','gouraud','EdgeLighting','phong','AmbientStrength', 0.5);

%% Draw Link 6
load baxter_Arm6_meters;
link6 = T06*link6;
n = length(link6(4,:));
C = ones(1,n)*0.5;
figure(1);
trisurf(t,link6(1,:),link6(2,:),link6(3,:),C,'FaceColor',[0 0 1],'EdgeColor',[0 0 1],'FaceLighting','gouraud','EdgeLighting','phong','AmbientStrength', 0.15);

%% Add a camera light, and tone down the specular highlighting
%camlight(-30,60);
campos([0;0;1])
camlight('headlight')
campos([0;1;0])
camlight('headlight')
campos([0;-1;0])
camlight('headlight')
% set material 
material('shiny');
%%setting the view
axis equal;
view(144,16);