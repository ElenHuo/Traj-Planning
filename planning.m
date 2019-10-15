clear
syms x y L1 L2 theta1 theta2;
syms acc Vm t1 T;
%arc generation
x1=3;y1=2;z1=1;
x2=2.7071;y2=2.3536;z2=1.6124;
x3=1.2929;y3=2.3536;z3=1.6124;
P1=[x1 y1 z1]';
P2=[x2 y2 z2]';
P3=[x3 y3 z3]';
%

T = 10;
L=5/4*pi;
t1 = 1;
acc = L/((T-t1)*t1); %(  (T-2t1)+T  )*Vm /2 = L
display(acc);
Vm = t1*acc;
display(Vm);
sample_time = 0.02;

x0 = 0.0;
y0 = 130;
r = 40;
Vlmax = Vm*r*0.001;
display(Vlmax);
% x=0.1;
% y=1.6;
% [s1,s2]=ik(x,y);
% display([s1;s2]);


% [x1,y1] = fk(s1(1),s1(2));
% [x2,y2] = fk(s2(1),s2(2));
% display([x1,y1]);
% display([x2,y2]);


t=0:sample_time:T;
s=trapezoid(t,acc,Vm,T);
%圆心角曲线
% plot(t,s)
% hold on
x=x0+r*cos(s);
y=y0+r*sin(s);

% plot(x,y)
% hold on
theta=[0,0];
j=1;
for i=0:1:T/sample_time
    theta = [theta;ik(x(j),y(j))];
    j=j+1;
end

j=1;
for i=0:1:T/sample_time-1
    theta(j,1:1:end) = theta(j+1,1:1:end);
    j=j+1;
end

%电机位置曲线
plot(t,theta(1:1:end-1,1))
hold on
plot(t,theta(1:1:end-1,2))
hold on

%速度曲线
sdot = diff(s)/sample_time;
plot(t,[sdot,0])
hold on

THETA = theta/pi*180;

fprintf('Motor_Angle1:\n')
formatSpec = '%4.2f,\n';
fprintf(formatSpec,THETA(1:1:end-1,1))

fprintf('Motor_Angle2:\n')
formatSpec = '%4.2f,\n';
fprintf(formatSpec,THETA(1:1:end-1,2))

grid on