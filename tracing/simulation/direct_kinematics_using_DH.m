function [frames] = direct_kinematics_using_DH(DH_matrix)

%% parsing the data in the DH_matrix and defining values of alpha, q, d, a
for i=1:1:6
    eval(['q',num2str(i),'=DH_matrix(',num2str(i),',1);']);
    eval(['d',num2str(i),'=DH_matrix(',num2str(i),',2);']);
    eval(['a',num2str(i),'=DH_matrix(',num2str(i),',3);']);
    eval(['alpha',num2str(i),'=DH_matrix(',num2str(i),',4);']);
end;
%% Compute DH matrices
A01 = DHmatrix(alpha1,q1,a1,d1);
A12 = DHmatrix(alpha2,q2,a2,d2);
A23 = DHmatrix(alpha3,q3,a3,d3);
A34 = DHmatrix(alpha4,q4,a4,d4);
A45 = DHmatrix(alpha5,q5,a5,d5);
A56 = DHmatrix(alpha6,q6,a6,d6);

A02 = A01*A12;
A03 = A02*A23;
A04 = A03*A34;
A05 = A04*A45;
A06 = A05*A56;

%%return the frames of each link
frames(:,:,1)=A01;
frames(:,:,2)=A02;
frames(:,:,3)=A03;
frames(:,:,4)=A04;
frames(:,:,5)=A05;
frames(:,:,6)=A06;



