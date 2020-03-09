% Chenyang(Tom) Wang 09/16/2017
% simulation of ProblemSet 3 part 3

% Define your state variables and give 
% the same reference directions as y to your states. Form your
% state vector x in the order of displacement first and then velocity. 
% Drive the state and output vector equations in the standard form. 

% Submission 1: Submit these two vector equations.
% let the angular displacement ¦È and angular velocity  ¦Ø
% be the state variables. After balancing all the torques acting on
% the inertial element, we can write down the two vector equations.
% Let x = [¦È;¦Ø]. Then we have: 
% (1) dx/dt = [0,1;-K/J,-B/J][¦È;¦Ø]+[0;1/J]u(t). 
% (2) y(t) = [1,0][¦È;¦Ø]+[0]u(t).
%--------------------------------------------------------------------------
clear all, clf
K = 101;J = 1;B = 2;
A = [0,1;-K/J,-B/J];
Bd = [0;1/J];
C = [1,0];
D = [0];
% continuous-time system sys is defined below
sys = ss(A,Bd,C,D)

% Create script lines for finding the input-output model.
[Q,P] = tfdata(sys,'v')
% Submission 2: After running the script,
% please submit the input-output equation by writing it by hand.
% we have P(D)y = Q(D)u, and my result is:
% Q = 0,0,1 P = 1,2,101
% thus the input-output equation will be:
% (D^2)y + 2Dy + 101y = u
%--------------------------------------------------------------------------
% Suppose we rotate the inertial element by 1 radian, 
% which is about 57 degrees, and gently let it go,
% which means zero initial velocity. 
% Suppose also the input torque is zero all the time: u(t) = 0 for all t.
% Please use tmax = 5, and divide the time interval from t = 0 to t = tmax 
% into 2000 subintervals for your Matlab time vector t.
tmax = 5; T = 1; F = 1; N =2000;
dt = tmax/N; M = T/dt;
t = [0:dt:tmax];
u = F*[zeros(1,N+1)]; % the input is a constant of zero
% inital state x0
x0 = [1;0];
% linear system simulation of system sys under input u
% from initial state x0 over time t.
[y,t,x] = lsim(sys,u,t,x0);
% thetamax, thetamin:graphical range for angular displacement
thetamax = 1.2; thetamin = -1;
% omegamax, omegamin:graphical range for angular velocity
omegamax = 10; omegamin = -10;
%figure 1 will display ¦È and ¦Ø againt time t
figure(1)
% plot ¦È against time t
subplot(2,1,1)
   plot(t,y)
   ylabel('\theta')
   xlabel('time t')
   title('angular displacement')
   grid
   axis([0 tmax thetamin thetamax]);
% plot ¦Ø and ¦È against time t
subplot(2,1,2)
   plot(t,x(:,2),t,5*y,'--')%¦Ø is the solid line ¦È is the dashed line
   grid
   ylabel('\omega')
   xlabel('time t')
   title('angular velocity and angular displacement')
   axis([0 tmax omegamin omegamax])
% Submission 3: Analyze the figure:
% From the two plots, we can conclude that:
% 1. Yes, at time t = 0, ¦È = 1 and ¦Ø = 0
% 2. Yes, the movement is oscillatory and the oscillation attenuates
% as time passes
% 3. Yes, this describes my childhood experience with swings
% 4. Yes, the velocity peaks when the angle is zero, and the velocity hits 
% zero when the angle peaks
%--------------------------------------------------------------------------
% Create script lines for computing the kinetic and spring energy
ek = (1/2)*J*(x(:,2).*x(:,2));
es = (1/2)*K*(y.*y);
% total energy e = ek + es
e = ek + es;
% Submission 4: What is the difference between y*y and y.*y?
% y*y is the normal matrix multiplication.
% y.*y is the element-by-element multiplication of both matrices.
% tmax, tmin:graphical range for time
timemax = 1; timemin = 0;
% Emax, Emin:graphical range for energy
Emax = 55; Emin = 0;
% figure 2 will display e,ek,and es againt time t
figure(2)
% plot e,ek,and es againt time t
% e in solid line,ek in a dashed line,es in a dotted line
   plot(t,e,t,ek,'--',t,es,'b:') 
   grid
   ylabel('energy e')
   xlabel('time t')
   title('e,ek,and es')
   axis([timemin timemax Emin Emax])
% Submission 5: Analyze the graph  
% 1.At the very beginning (t = 0),the total energy is at its maximum.
% 2.At the very beginning,the kinetic energy is zero and the spring energy 
% is at its maximum.
% 3.When the kinetic energy hits zero,the spring energy peaks.And when the 
% spring energy hits zero, the kinetic energy peaks.
% 4.Yes,the energy in the system is being passed from one form of energy to 
% another form of energy and then passed back to the first form of energy.
% 5.Yes,as the time passes,the total energy gets smaller and smaller. 
%--------------------------------------------------------------------------
% Submission 6: Recall that the input-output equation is:
% (D^2)y + 2Dy + 101y = u
% Create script lines for finding the general solution of the 
% input-output equation under zero input using
% the symbolic mathematics toolbox.
diffeqn = 'D2y+2*Dy+101*y = 0';
indepvar = 't';
ysym = dsolve(diffeqn, indepvar)
ysym = simplify(ysym)
% Submission 7: Submit the output of your script,the general solution 
% of the input-output equation under zero input. 
% My general solution is: "exp(-t)*(C1*cos(10*t) + C2*sin(10*t))"
%--------------------------------------------------------------------------
% Submission 8: Submit the value of the system angular frequency ¦Ø_s.
% Given the general solution, the system angular frequency ¦Ø_s is 10.
%--------------------------------------------------------------------------
% Create script lines for computing the sinusoidal inputs with the
% following three variables:1.the zero initial state vector for x0
% 2.a 3-dimensional Matlab vector omega0 consisting of input 
% angular frequencies, ¦Ø_0 = 5, 10, 15. 3. the input amplitude Amp = 20
x_0 = [0;0];
omega0 = [5,10,15];
Amp = 20;
% When ¦Ø_0 = 5:
u_1 = Amp*cos(omega0(:,1)*t);
[y_1,t,x] = lsim(sys,u_1,t,x_0);
% When ¦Ø_0 = 10:
u_2 = Amp*cos(omega0(:,2)*t);
[y_2,t,x] = lsim(sys,u_2,t,x_0);
% When ¦Ø_0 = 15:
u_3 = Amp*cos(omega0(:,3)*t);
[y_3,t,x] = lsim(sys,u_3,t,x_0);
% Create script lines for generating the third figure, 
% which consists of three graphs, one on top of another. 
% Each graph should show the displacement y against the time t. 
% Each of the three graphs should show the value of the input 
% angular frequency ¦Ø_0 perhaps in its x-axis label.
% Submission 9: Submit the third figure. 
figure(3);
subplot(3,1,1)
   plot(t,y_1)
   grid
   ylabel('\theta')
   xlabel('time t when ¦Ø_0 = 5')
   title('angular displacement')
   axis([0 tmax thetamin thetamax])
subplot(3,1,2)
   plot(t,y_2);
   grid
   ylabel('\theta')
   xlabel('time t when ¦Ø_0 = 10')
   title('angular displacement')
   axis([0 tmax thetamin thetamax])
subplot(3,1,3)
   plot(t,y_3);
   grid
   ylabel('\theta')
   xlabel('time t when ¦Ø_0 = 15')
   title('angular displacement')
   axis([0 tmax thetamin thetamax])
% Submission 10: Analyze the figure
% 1. Although the amplitudes of the input torques u(t) have the same 
% amplitude value, Amp = 20, the amplitudes of the output angular 
% displacements, y(t) = ¦È(t), vary.
% 2. Yes, I got a a particularly large output amplitude when the input 
% frequency ¦Ø_0 and the system frequency ¦Ø_s are both 10. And this 
% phenomenon is called resonance.
