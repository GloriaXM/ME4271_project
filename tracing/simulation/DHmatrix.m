%#eml
function [T] = DHmatrix(alpha,q,a,d)

t11 = cos(q);
t12 = -cos(alpha) * sin(q);
t13 = sin(alpha) * sin(q);
t14 = a * cos(q);
t21 = sin(q);
t22 = cos(q) * cos(alpha);
t23 = -sin(alpha) * cos(q);
t24 = a * sin(q);
t31 = 0;
t32 = sin(alpha);
t33 = cos(alpha);
t34 = d;
t41 = 0;
t42 = 0;
t43 = 0;
t44 = 1;
T = [t11 t12 t13 t14;
     t21 t22 t23 t24;
     t31 t32 t33 t34;
     t41 t42 t43 t44];
