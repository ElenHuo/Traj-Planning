function [x,y] = fk(theta1,theta2)
L1 = 1;
L2 = 1;
x = L1*cos(theta1) + L2*cos(theta2 + theta1);
y = L1*sin(theta1) + L2*sin(theta2 + theta1);
end