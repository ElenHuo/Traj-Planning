function [solution1,solution2] = ik(x,y)
% L1 = 1;
% L2 = 1;
% r = sqrt(x*x+y*y);
% 
% phi = atan2(y,x);
% solution1(1) = phi - acos((r*r+L1*L1-L2*L2)/(2*r*L1));
% solution2(1) = phi + acos((r*r+L1*L1-L2*L2)/(2*r*L1));
% 
% psi = acos((L1*L1+L2*L2-r*r)/(2*L2*L1));
% solution1(2) = pi - psi;
% solution2(2) = -pi + psi;

L1 = 120;
L2 = 80;
D = 60;
r = sqrt(x*x + y*y);
r1 = sqrt((x+D/2)^2 + y^2);
r2 = sqrt((x-D/2)^2 + y^2);


% if atan2(y,x)>=0
%     phi = pi/2 - atan2(y,x);
% else
%     phi = -(atan2(y,x) + pi/2);
% end
% solution1(1) = pi/2 - acos((r*r+L1*L1-L2*L2)/(2*r*L1)) + phi;
% solution1(2) = pi/2 - acos((r*r+L1*L1-L2*L2)/(2*r*L1)) - phi;

solution1(1) = pi - acos((r1^2 + L1^2 - L2^2)/(2*r1*L1)) - acos(( (D/2)^2 + r1^2 -r^2)/(D*r1));
solution1(2) = pi - acos((r2^2 + L1^2 - L2^2)/(2*r2*L1)) - acos(( (D/2)^2 + r2^2 -r^2)/(D*r2));


% psi = 0;
% solution1(2) = 0;
% solution2(2) = 0;
end