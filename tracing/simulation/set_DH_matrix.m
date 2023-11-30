function DH_matrix=set_DH_matrix(q)
%%this function sets the DH parameters for the meca500 robot. The first column
%%is the theta vector, second column is the d vector, third column is the
%%a vector, fourth column is the aklpha vector. See nabil's notes about DH
%%parameters on the Wiki.

if nargin<=1
    if(nargin==0)
        %%set joint angles to be zero by default
        for i=1:1:6
            eval(['theta',num2str(i),' = 0 ;']);
        end;
    end;
    if (nargin==1)
        for i=1:1:6
            eval(['theta',num2str(i),' =q(',num2str(i),');']);
        end;
    end;
    
    %%define other link parameters
    a1=0.069;   alpha1=pi/2;   d1=0.290; 
    a2=0;       alpha2=pi/2;    d2=0;
    a3=-0.069;  alpha3=-pi/2;   d3=0.400;
    a4=0;       alpha4=pi/2;    d4=0; 
    a5=0;       alpha5=-pi/2;    d5=0.400; 
    a6=0.240;   alpha6=0;       d6=0; 
    
    DH_matrix=[
        theta1,d1,a1,alpha1;...
        theta2+pi/2,d2,a2,alpha2;...
        theta3,d3,a3,alpha3;...
        theta4,d4,a4,alpha4;...
        theta5,d5,a5,alpha5;...
        theta6-pi/2,d6,a6,alpha6;...
        ];
else
    disp('error in number of inputs for set_DH_mtarix');
end;
