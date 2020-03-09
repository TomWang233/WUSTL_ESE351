% Chenyang(Tom) Wang 09/22/2017
% simulation of ProblemSet 4 part 3

% Define your state variables. Give the same reference direction 
% as y to your voltage state v, namely upward, and give a downward 
% direction to your current state i. Form your state vector x in the
% order of current and then voltage. 
% Drive the state and output vector equations in the standard form.
% Submission 1: Submit these two vector equations.
% Let x = [i;v]. Then we have:
% 1.dx/dt = [0,1/L;-1/C,-1/RC][i;v]+[0;1/C]u(t);
% 2.y(t) = [0,1][i;v]+[0]u(t);
%--------------------------------------------------------------------------
clear all, clf
Cap = 1; R = 0.5; L = 1/170;
A = [0,1/L;-1/Cap,-1/(R*Cap)];
B = [0;1/Cap];
C = [0,1];
D = [0];
% continuous-time system sys is defined below
sys = ss(A,B,C,D)
% Create Matlab script lines for computing the impulse response h(t) 
% of the system. Please use tmax = 3,and divide the time interval 
% from t = 0 to t = tmax into 4000 subintervals for your Matlab 
% time vector t.
tmax = 3; T = 1; N =4000 ;
dt = tmax/N; 
t = [0:dt:tmax];
[y,t,x] = impulse(sys);
%figure 1 will display v and i againt time t.
figure(1);
% time range for the graph
tmin = -1; tgraph = 3;
% voltage range for the graph
vgraphmin = -1; vgraphmax = 1.2;
% current range for the graph
igraphmin = -10; igraphmax = 15;
% plot v againt time t
dt = 1/1000;
tseg = [-1:dt:0];
vseg = zeros(1,1001);
iseg = zeros(1,1001);
subplot(2,1,1)
   plot(t,y)
   grid
   ylabel('voltage')
   xlabel('time t')
   title('voltage v across the capacitor against time t')
   axis([-1 tgraph vgraphmin vgraphmax]);
   hold on
   plot(tseg,vseg);
   legend('voltage v when t > 0','voltage v when t < 0')
% plot i against time t
subplot(2,1,2)
   plot(t,x(:,1),t,10*y,'--');% voltage is the dashed line
   grid
   ylabel('current')
   xlabel('time t')
   title('current i flowing through the inductor against time t')
   axis([-1 tgraph igraphmin igraphmax]);
   hold on
   plot(tseg,iseg);
   legend('current i when t > 0','10*voltage v when t > 0',...
       'current i when t < 0');
   hold off       
% Submission 2: Submit the figure.
% Submission 3: Analyze the figure:
% 1.Voltage jumps at time t = 0.
% 2.Because only voltage across the capacitor can jump instantly.
% 3.Yes,the state variables are oscillatory and the oscillation 
% attenuate as time passes.
% 4.Yes,the voltage v peaks in magnitude when the current i is zero, and 
% the current i peaks in magnitude when the voltage v becomes zero.
%--------------------------------------------------------------------------
% Create script lines for computing the electrical potential energy e_p, 
% the magnetic field energy e_m, and the total energy e.
e_p = (1/2)*Cap*(y.*y); e_m = (1/2)*L*(x(:,1).*x(:,1)); e = e_p + e_m;
% Create script lines for generating the second figure, which consists of 
% one graph showing three variables: the total energy e in solid line, 
% the electrical potential energy e_p in a dashed line and the magnetic
% field energy e_m in a dotted line, all against the time t.
% Create figure 2.
figure(2);
% Graphical range for time t: 0 to 1
t_graph = 1;
% Graphical range for energy e: 0 to 0.6
egraph = 0.6;
% e in solid line,e_p in a dashed line,e_m in a dotted line
plot(t,e,t,e_p,'--',t,e_m,'b:') 
grid
ylabel('energy e')
xlabel('time t')
title('Energies in the system')
axis([0 t_graph 0 egraph])
legend('total energy E','electrical potential energy E_p',...
    'magnetic field energy E_m');
% Submission 4: Submit the figure.
% Submission 5: Analyze the graph:
% 1.At the very beginning (t = 0), the total energy is at its maximum,
% the magnetic field energy is at zero, and the electrical potential energy
% is at its maximum.
% 2.Yes,when the electrical potential energy hits zero, the magnetic field 
% energy peaks,and when the magnetic field energy hits zero, the electrical 
% potential energy peaks.
% 3.Yes,the energy in the system is being passed from one form of energy to 
% another form of energy and then passed back to the first form of energy.
% And as the time passes, the total energy gets smaller and smaller. This 
% is because of the heat lose in the resistor.
%--------------------------------------------------------------------------
% Create script lines for converting your state-space model into 
% an input-output model and find the input-output model of the circuit.
[Q,P] = tfdata(sys,'v');
% Submission 6: Submit the input-output equation:
% We have P(D)y = Q(D)u, and my result is:
% Q = 0,1,0 P = 1,2,170
% thus the input-output equation will be:
% (D^2)y + 2Dy + 170y = Du
%--------------------------------------------------------------------------
% Create script lines for finding the general solution of the input-output 
% equation under zero input using the symbolic mathematics toolbox.
diffeqn = 'D2y+2*Dy+170*y = 0';
indepvar = 't';
ysym = dsolve(diffeqn, indepvar)
ysym = simplify(ysym)
% Submission 7: Submit the output of your script, namely the general 
% solution of the input-output equation under zero input.
% My general solution is: "exp(-t)*(C1*cos(13*t) + C2*sin(13*t))"
%--------------------------------------------------------------------------
% Submission 8: Submit the value of the system angular frequency ¦Ø_s
% Given the the general solution, the system angular frequency ¦Ø_s is 13.
%--------------------------------------------------------------------------
% Create script lines for computing the sinusoidal inputs with the
% following three variables:1.the zero initial state vector for x0
% 2.a 3-dimensional Matlab vector omega0 consisting of input 
% angular frequencies, ¦Ø_0 = 5, 13, 20. 3. the input amplitude Amp = 2
x_0 = [0;0]; omega0 = [5,13,20]; Amp = 2;
% When ¦Ø_0 = 5:
u_1 = Amp*cos(omega0(:,1)*t);
[y_1,t] = lsim(sys,u_1,t,x_0);
% When ¦Ø_0 = 13:
u_2 = Amp*cos(omega0(:,2)*t);
[y_2,t] = lsim(sys,u_2,t,x_0);
% When ¦Ø_0 = 20:
u_3 = Amp*cos(omega0(:,3)*t);
[y_3,t] = lsim(sys,u_3,t,x_0);
% Create script lines for generating the third figure, 
% which consists of three graphs, one on top of another. 
% Each graph should show the voltage y against the time t. 
% Each of the three graphs should show the value of the input 
% angular frequency ¦Ø_0 perhaps in its x-axis label.
% Submission 9: Submit the third figure. 
figure(3);
subplot(3,1,1)
   plot(t,y_1)
   grid
   ylabel('voltage')
   xlabel('time t when ¦Ø_0 = 5')
   title('y against time t')
   axis([0 tmax vgraphmin vgraphmax])
subplot(3,1,2)
   plot(t,y_2);
   grid
   ylabel('voltage')
   xlabel('time t when ¦Ø_0 = 13')
   title('y against time t.')
   axis([0 tmax vgraphmin vgraphmax])
subplot(3,1,3)
   plot(t,y_3);
   grid
   ylabel('voltage')
   xlabel('time t when ¦Ø_0 = 20')
   title('y against time t.')
   axis([0 tmax vgraphmin vgraphmax])
% Submission 10: Analyze the figure:
% 1.Although the amplitudes of the input torques u(t) have the same 
% amplitude value, Amp = 2, the amplitudes of the output voltage, 
% y(t) = v(t), vary.
% 2. Yes, I got a a particularly large output amplitude when the input 
% frequency ¦Ø_0 and the system frequency ¦Ø_s are both 13. And this 
% phenomenon is called resonance.