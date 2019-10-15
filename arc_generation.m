%[1 0 0 2;0 cos(pi/3) -sin(pi/3) 2;0 sin(pi/3) cos(pi/3) 1;0 0 0 1]*[1 0 0 1]'
%[1 0 0 2;0 cos(pi/3) -sin(pi/3) 2;0 sin(pi/3) cos(pi/3) 1;0 0 0 1]*[cos(pi/4) sin(pi/4) 0 1]'
%[1 0 0 2;0 cos(pi/3) -sin(pi/3) 2;0 sin(pi/3) cos(pi/3) 1;0 0 0 1]*[-cos(pi/4) sin(pi/4) 0 1]'
function [theta,G,R]=arc_generation(P1,P2,P3)
syms R x0 y0 z0 x1 y1 z1 x2 y2 z2 x3 y3 z3

% x1=3;y1=2;z1=1;
% x2=2.7071;y2=2.3536;z2=1.6124;
% x3=1.2929;y3=2.3536;z3=1.6124;

x1=P1(1);y1=P1(2);z1=P1(3);
x2=P2(1);y2=P2(2);z2=P2(3);
x3=P3(1);y3=P3(2);z3=P3(3);

eqn1 = (x1-x0)^2+(y1-y0)^2+(z1-z0)^2 == R^2;
eqn2 = (x2-x0)^2+(y2-y0)^2+(z2-z0)^2 == R^2;
eqn3 = (x3-x0)^2+(y3-y0)^2+(z3-z0)^2 == R^2;
eqn4 = det([x0,y0,z0,1;x1,y1,z1,1;x2,y2,z2,1;x3,y3,z3,1;])==0;
eqn5 = R>0;
[x0,y0,z0,R]=solve(eqn1,eqn2,eqn3,eqn4,eqn5,x0,y0,z0,R);
% display(double([x0,y0,z0,R]));

P0=double([x0,y0,z0]');
% P1=[x1 y1 z1]';
% P2=[x2 y2 z2]';
% P3=[x3 y3 z3]';
P01=P1-P0;
P03=P3-P0;
xc=(P1-P0)/norm(P1-P0);
zc=cross((P2-P1),(P3-P2))/norm(cross((P2-P1),(P3-P2)));
yc=cross(zc,xc);
Rotation=[xc yc zc];
if P03(2)>=0
    theta=acos( P01'*P03/ (norm(P01)*norm(P03)) );
else
    theta=2*pi - acos( P01'*P03/ (norm(P01)*norm(P03)) );
end
G=[Rotation P0;0 0 0 1];
end
