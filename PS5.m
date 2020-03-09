% Chenyang(Tom)Wang,10/02/2017
% imulation of PS5 Part 3

% We will try the rates of RP = 0.05, RM = 0.08, RS = 0.07 and RI = 0.08. 
% We also suppose the expense part is E = 0.85 (85%) and the investment 
% transfer is I = 0.1 (10%). So 5% stays in your checking account. 
% Create Matlab script lines for defining these parameters.
R_P = 0.05; R_M = 0.08; R_S = 0.07; R_I = 0.08; E = 0.85; I = 0.1;
% Create Matlab script lines for defining the matrices, A, B, C, and D 
% in your state-space model and then for defining your system sys.
A=[1+R_P,0,0,0,0;0,1+R_M,0,0,0;0,0,1+R_S,0,0;0,0,1-E-I,1,0;0,0,I,0,R_I+1]
B=[0;0;0;0;1];
C=[0,0,0,1,1];
D=[0];
kstep = 1;
sys = ss(A,B,C,D,kstep);
% Create Matlab script lines for generating the time vector k
kmax = 40; N = 40;
dk = kmax/N;
k = [0:dk:kmax];
% Create the input vector u
u = [100,zeros(1,N)];
% Create script lines for defining the initial state x0
x0 = [1,1,70,20,0];
% Create script lines for computing the response of the system for 
% the given input and initial conditions.
[y,k,x] = lsim(sys,u,k,x0);
% Create script lines for generating a first figure, which consists of one 
% graph of the CPI and SMI as well as the growth of your salary, which is 
% your salary of year k divided by your salary of year 0. 
% Graphical ranges: 0 to kmax = 40 for the time, 
% and 0 to 50 for the indices. 
ind_min = 0; ind_max = 50;
figure(1)
plot(k,x(:,1),k,x(:,2),'--',k,x(:,3)/70,'-.');
title('CPI,SMI and the growth of salary')
xlabel('year k')
ylabel('growth')
grid
axis([0,kmax,ind_min,ind_max]);
legend('CPI','SMI','Growth of Salary')
% Create script lines for generating a second figure, which consists of 
% one graph of your salary and your investment account balance in 
% thousand dollars against time k
figure(2)
plot(k,x(:,3),k,x(:,5),'--')
title('Salary and Investment Account Balance')
xlabel('year k')
ylabel('Balance(thousand)')
grid
axis([0,kmax,0,20000]);
legend('Salary','Investment Account Balance')
% You realize that million dollars in 40 years may not buy as much as now. 
% Create script lines for generating a third figure, which consists of 
% one graph of your salary and your investment account balance adjusted for 
% inflation against time k.
figure(3)
salary = (x(:,3))./(x(:,1)); invest = (x(:,5))./(x(:,1));
plot(k,salary,':',k,invest,'--')
title('Adjusted Values')
xlabel('year k')
ylabel('Balance(thousand)')
grid
axis([0,kmax,0,2000]);
legend('Salary','Investment Account Balance')
% You could postpone your retirement. 
% So run the same program with kmax = 50.
kmax_1 = 50; N_1 = 50;
dk_1 = kmax_1/N_1;
k_1 = [0:dk_1:kmax_1];
u_1 = [100,zeros(1,N_1)];
[y_1,k_1,x_1] = lsim(sys,u_1,k_1,x0);
figure(4)
plot(k_1,x_1(:,1),k_1,x_1(:,2),'--',k_1,x_1(:,3)/70,'-.');
title('CPI,SMI and Growth of Salary postponed')
xlabel('year k')
ylabel('growth')
grid
axis([0,kmax_1,ind_min,ind_max]);
legend('CPI','SMI','Growth of Salary')
figure(5)
plot(k_1,x_1(:,3),k_1,x_1(:,5),'--')
title('Salary and Investment Account Balance postponed')
xlabel('year k')
ylabel('Balance(thousand)')
grid
axis([0,kmax_1,0,20000]);
legend('Salary','Investment Account Balance')
figure(6)
salary_1 = (x_1(:,3))./(x_1(:,1)); invest_1 = (x_1(:,5))./(x_1(:,1));
plot(k_1,salary_1,':',k_1,invest_1,'--')
title('Adjusted Values postponed')
xlabel('year k')
ylabel('Balanced(thousand)')
grid
axis([0,kmax_1,0,2000]);
legend('Salary','Investment Account Balance')