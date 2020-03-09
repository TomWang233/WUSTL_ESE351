% Chenyang(Tom) Wang 09/09/2017
% simulation of Problem 1.10.3
clear all, clf
K = 1;M = 1;B = 1;
A = [0,1;-K/M, -B/M];
Bm = [0;1/M];
C = [-K/M, -B/M];
D = [1/M];
% continuous-time system sys is defined below
sys = ss(A,Bm,C,D);
% time interval 0 to tmax is divided by N
% piecewise constant input of magnitude F from time 0 to T,
% then magnitude 0 from time T to time tmax.
% suppose that there is no input:u(t) = 0 for all t.
tmax = 20; T = 1; F = 1; N =2000;
dt = tmax/N; M = T/dt;
t = [0:dt:tmax];
u = F*[zeros(1,N+1)]; % the input is a constant of zero
% inital state x0
x0 = [-1;0];
% linear system simulation of system sys under input u
% from initial state x0 over time t.
[y,t,x] = lsim(sys,u,t,x0);
% umax, umin:graphical range for inpuit force
umax = 2.5; umin = -1.5;
% zmax, zmin:graphical range for positions
zmax = 2.5; zmin = -1.5;
% figure 1 will display input u and output y againt time t
figure(1)
% plot the input u against time t
subplot(2,1,1)
   plot(t,u)
   ylabel('u')
   xlabel('time t')
   title('Input Force u')
   grid
   axis([0 tmax umin umax]);
% plot the output y against time t
subplot(2,1,2)
   plot(t,y)
   grid
   ylabel('y')
   xlabel('time t')
   title('Output Displacement y')
   axis([0 tmax zmin zmax])

% Analysis£ºinitial displacement 1 with input constantly 0, we can see that
% the initial displacement in this system is 1, and start to decreasing
% to negative, and come bcak to positive and finally decrease to 0. 
% Oscillation exits and attenuate.