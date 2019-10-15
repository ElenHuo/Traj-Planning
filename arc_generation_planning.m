clear
syms x y L1 L2 theta1 theta2;
syms acc Vm t1 T;
%arc generation
radius = 25;
x1=radius;y1=0+160;z1=0;
x2=0;y2=radius+160;z2=0;
x3=radius*cos(pi/10);y3=-radius*sin(pi/10)+160;z3=0;
P1=[x1 y1 z1]';
P2=[x2 y2 z2]';
P3=[x3 y3 z3]';
[L,G,r]=arc_generation(P1,P2,P3);%行程角，变换矩阵，半径
%
r=double(r);
x0 = 0;
y0 = 0;
% r = 40;
% L=2*pi;
T = 10;
t1 = 1;
acc = L/((T-t1)*t1); %(  (T-2t1)+T  )*Vm /2 = L %角加速度 弧度/s^2
display(acc);
Vm = t1*acc;%角速度 弧度/s
display(Vm);
sample_time = 0.02;

Vlmax = Vm*r*0.001;%线速度 m/s
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



%scurve parame calculation
%   L 为 3 - 9
syms J Vm_s am_s t1_s t2_s t3_s
t1_s=0.5;
J=0.4;
am_s=0.4;
eqn1 = 1/6*J*t1_s.^3 + 1/2*J*t1_s.^2*(t2_s-t1_s) + 1/2*am_s*(t2_s-t1_s).^2    +   (1/2*J*t1_s^2+am_s*(t2_s-t1_s))*(t3_s-t2_s)  -  1/6*J*(t3_s-t2_s).^3 + 1/2*am_s*(t3_s-t2_s).^2   +    Vm_s*(T/2-t3_s) == L/2;
eqn2 = Vm_s==1/2*J*t1_s^2+1/2*J*(t3_s-t2_s)^2+am_s*(t3_s-t1_s);
eqn3 = t1_s==t3_s-t2_s;
eqn4 = t2_s>t1_s;
eqn5 = t3_s<T/2;
[g,gg,ggg]=solve(eqn1,eqn2,eqn3,eqn4,eqn5,t2_s,t3_s,Vm_s);
scurve_param=double([g,gg,ggg]);

% %scurve
% haha=s_curve(L,t1_s,J,am_s,scurve_param,t,T);
% plot(t,haha)
% hold on
% %scurve



%圆心角曲线
% plot(t,s)
% hold on
x=x0+r*cos(s);
y=y0+r*sin(s);
Size = size(x);
z=zeros(1,Size(2));

for i=1:1:Size(2)
    new = G*[x(i);y(i);0;1];
    x(i) = new(1);
    y(i) = new(2);
    z(i) = new(3);
end

%圆弧轨迹
figure
scatter3(x,y,z,'MarkerEdgeColor','g','MarkerFaceColor',[0 1 0]);
hold on
scatter3(P1(1),P1(2),P1(3),'MarkerEdgeColor','k','MarkerFaceColor',[0 0 0]);
hold on
scatter3(P2(1),P2(2),P2(3),'MarkerEdgeColor','k','MarkerFaceColor',[0 0 0]);
hold on
scatter3(P3(1),P3(2),P3(3),'MarkerEdgeColor','k','MarkerFaceColor',[0 0 0]);
hold on
%圆弧轨迹
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

figure
%电机位置曲线
plot(t,theta(1:1:end-1,1))
hold on
plot(t,theta(1:1:end-1,2))
hold on

%电机速度曲线
m_v = diff(theta)/sample_time;
plot(t,m_v(1:1:end,1));
hold on
plot(t,m_v(1:1:end,2));
hold on

% %电机加速度曲线
% m_v = diff(m_v)/sample_time;
% m_v = [m_v;0 0];
% plot(t,m_v(1:1:end,1));
% hold on
% plot(t,m_v(1:1:end,2));
% hold on

%末端速度曲线
sdot = diff(s)/sample_time;
plot(t,[sdot,0])

% % 下位机数据生成
% THETA = theta/pi*180;
% fprintf('Motor_Angle1:\n')
% formatSpec = '%4.2f,\n';
% fprintf(formatSpec,THETA(1:1:end-1,1))
% 
% fprintf('Motor_Angle2:\n')
% formatSpec = '%4.2f,\n';
% fprintf(formatSpec,THETA(1:1:end-1,2))

grid on