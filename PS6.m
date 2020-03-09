% Chenyang(Tom)Wang,10/10/2017
% simulation of PS6 Part 3
clear all, clf
% Form the state vector x in the order of displacement z and velocity v 
% and find a set of state and output equations in the standard form.
% Let M = B = 1 and D = 10.
M = 1; B = 1; D = 10;
% Create Matlab script lines for defining the matrices, a, b, c, and d, 
% in your state-space model and then for defining your system sys.
a = [0,1;0,-B/M];
b = [0;1/M];
c = [1,0];
d = [0];
sys = ss(a,b,c,d);
% Create Matlab script lines for generating the time vector t.
tmax = D; T = 5; N = 2000; F = 1;
dt = tmax/N; M = T/dt;
t = [0:dt:tmax];
% Create Matlab script lines for defining the initial state x0 and 
% the input vector u.
x0 = [0;5];
u = [zeros(1,N+1)];
x0_1 = [0;0];
u_1 = F*[ones(1,M+1) zeros(1,N-M)];
% Compute the state, x(t), and the output, y(t), over the time interval 
% between t = 0 and tmax = 10.
[y_zi,t,x_zi] = lsim(sys,u,t,x0);
[y_zs,t,x_zs] = lsim(sys,u_1,t,x0_1);
[y,t,x] = lsim(sys,u_1,t,x0);
% Create a first figure, which shows the zero-input output response yzi(t) 
% against time t. Graphical ranges:distance 0 <= z <= 10;time 0 <= t <= 10.
dis_min = 0; dis_max = 10;
figure(1)
plot(t,y_zi);
hold on 
% Add the graph of the zero-input output response yzs(t) against time t 
% on the first figure   
plot(t,y_zs,':');
hold on
% Add the graph of the output response y(t) against time t 
% on the first figure.
plot(t,y,'--');
hold off
xlabel('time t')
ylabel('distance traveled ')
title('three different outputs against time t')
legend('zero input response yzi','zero state response yzs',...
    'combined output response y');
grid
axis([0,tmax,dis_min,dis_max]);
% Create script lines for a second figure, which shows 
% three speed responses: the zero-input velocity x_zi(t), 
% the zero-state velocity x_zs(t), the velocity for 
% the combined situation x(t), all against time t. 
figure(2)
plot(t,x_zi(:,2),t,x_zs(:,2),'--',t,x(:,2),':');
xlabel('time t')
ylabel('speed v')
title('three different speed responses against time t')
legend('zero-input velocity xzi','zero-state velocity xzs',...
    'velocity for the combined situation x');
grid
axis([0,tmax,dis_min,5]);

   