clf, clear all
num = [0 1];
den = [1 0.4 1];
omega = -10:0.001:10;
fresp(num,den,omega);
R = 1; C = 1;
tmax = 10;
t = 0:.01:tmax;
omega = sqrt(3);
omega_1 = 100*sqrt(3);
u_1 = cos(omega*t);
u_2 =  cos(omega_1*t);
s_1 = i*omega;
s_2 = i*omega_1;
H_1 = 1/(1+s_1*R*C);
H_2 = 1/(1+s_2*R*C);
ys_1 = abs(H_1)*cos(omega*t+angle(H_1));
ys_2 = abs(H_2)*cos(omega_1*t+angle(H_2));
inputmin = -1.5;inputmax = 1.5;
outputmin = -1.5; outputmax = 1.5;
figure(1)
  subplot(2,2,1)
  plot(t,u_1);
  grid
  ylabel('input u')
  xlabel('time t')
  title('sinusoidal input with ¦Ø_0 = sqrt(3) ')
  axis([0 tmax inputmin inputmax])
  subplot(2,2,2)
  plot(t,ys_1);
  grid
  ylabel('ss response')
  xlabel('time t')
  title('ss response with ¦Ø_0 = sqrt(3) ')
  axis([0 tmax outputmin outputmax])
  subplot(2,2,3)
  plot(t,u_2);
  grid
  ylabel('input u')
  xlabel('time t')
  title('sinusoidal input with ¦Ø_0 = 100*sqrt(3) ')
  axis([0 tmax inputmin inputmax])
  subplot(2,2,4)
  plot(t,ys_2);
  grid
  ylabel('ss response')
  xlabel('time t')
  title('ss response with ¦Ø_0 = 100*sqrt(3) ')
  axis([0 tmax outputmin outputmax])
 
num_1 = [ 0 0 1 1];
den_1 = [ 0 0 0 2];
theta = [-3*pi: pi/100: 3*pi];
dfresp(num_1,den_1,theta)
theta_1 = pi/2
theta_2 = pi;
z_1 = exp(i*theta_1);
z_2 = exp(i*theta_2);
H_1 = (z_1+1)/2;
H_2 = (z_2+1)/2;
gain_1 = abs(H_1);
gain_2 = abs(H_2);
phase_1 = angle(H_1);
phase_2 = angle(H_2);
K = 20; % max time range
k = [0:K]; % discrete time
u_1 = cos(theta_1*k);
u_2 = cos(theta_2*k);
angles_1 = theta_1*k + phase_1*ones(size(k));
angles_2 = theta_2*k + phase_2*ones(size(k));
yss_1 = diag(gain_1)*cos(angles_1);
yss_2 = diag(gain_2)*cos(angles_2);
figure(3)
  subplot(2,2,1)
  stem(k,u_1);
  grid
  ylabel('input u')
  xlabel('time k')
  title('sinusoidal input with theta = pi/2 ')
  axis([0 K inputmin inputmax])
  subplot(2,2,2)
  stem(k,yss_1);
  grid
  ylabel('ss response')
  xlabel('time k')
  title('ss response with theta = pi/2 ')
  axis([0 K outputmin outputmax])
  subplot(2,2,3)
  stem(k,u_2);
  grid
  ylabel('input u')
  xlabel('time k')
  title('sinusoidal input with theta = pi ')
  axis([0 K inputmin inputmax])
  subplot(2,2,4)
  stem(k,yss_2);
  grid
  ylabel('ss response')
  xlabel('time k')
  title('ss response with theta = pi ')
  axis([0 K outputmin outputmax])
