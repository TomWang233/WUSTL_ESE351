% Chenyang(Tom) Wang 12/02/2017
% PS11 Part3
% (a) input message signal
T = 1;
n = 2000;
t = [0:T/n:T];
u = exp(-2*t).*sin(6*pi*t);
omegamin = -100*pi;omegamax = 100*pi;
n_omega = 4000;
omega = 0:omegamax/n_omega:omegamax;
[U,Omega,Mag,Phase] = ftrans(u,t,omega);
figure(1)
  subplot(3,2,1)
  plot(t,u);
  grid
  ylabel('input u')
  title('input message signal')
  axis([0 1 -3 3]);
% (b) compute the Fourier spectrum for u(t)
  subplot(3,2,2)
  plot(Omega,Mag);
  grid
  ylabel('Magnitude |U|')
  title('Fourier spectrum')
  axis([omegamin omegamax 0 1.3]);
% (c) compute a biased message signal v(t) 
v = 1 + u;
  subplot(3,2,3)
  plot(t,v,t,u,'--');
  grid
  ylabel('input v')
  legend('biased signal','original signal');
  title('biased message signal')
  axis([0 1 -3 3]);
% (d) compute the Fourier spectrum for v(t)
[V,Omega,Mag,Phase] = ftrans(v,t,omega);
  subplot(3,2,4)
  plot(Omega,Mag);
  grid
  ylabel('Magnitude |V|')
  axis([omegamin omegamax 0 1.3]);
% (e) compute a modulated biased message signal w(t)
w = v.*cos(50*pi*t);
  subplot(3,2,5)
  plot(t,w,t,v,'--',t,-v,'--');
  grid
  ylabel('modulated biased signal w')
  title('modulated biased signal')
  legend('modulated biased signal','biased signals');
  axis([0 1 -3 3]);
% (f) compute the Fourier spectrum for w(t)
[W,Omega,Mag,Phase] = ftrans(w,t,omega);
  subplot(3,2,6)
  plot(Omega,Mag);
  grid
  xlabel('Frequency \omega')
  ylabel('Magnitude |W|')
  axis([omegamin omegamax 0 1.3]);
%--------------------------------------------------------------------------
% start the second graph about envelope demodulation
% (a) We repeat the bottom two graphs of the first figure as the top two 
% figures of the second figure so that the second figure starts from the 
% modulated signal.
figure(2)
  subplot(3,2,1);
  plot(t,w,t,v,'--',t,-v,'--');
  grid
  ylabel('modulated biased signal w')
  legend('modulated biased signal','biased signals');
  title('modulated biased signal')
  axis([0 1 -3 3]);
  subplot(3,2,2)
  plot(Omega,Mag);
  grid
  ylabel('Magnitude |W|')
  title('Fourier spectrum ')
  axis([omegamin omegamax 0 1.3]);
% (b) compute a half-rectified signal x(t) from w(t)
x = max(w,0);
  subplot(3,2,3);
  plot(t,x,t,v,'--');
  grid
  ylabel('input x');
  title('a half-rectified signal x(t) from w(t)');
  legend('half-rectified signal','biased signals');
  axis([0 1 -3 3]);
% (c) compute the Fourier spectrum for x(t)
[X,Omega,Mag,Phase] = ftrans(x,t,omega);
  subplot(3,2,4)
  plot(Omega,Mag);
  grid
  ylabel('Magnitude |X|')
  axis([omegamin omegamax 0 1.3]);
% (d) compute the Fourier spectrum for the output y(t)
Y = ifilter(X,Omega,0,20*pi,3);%ifilter function from Solution F.1.1
Mag = abs(Y);
subplot(3,2,6)
plot(Omega,Mag)
grid
xlabel('Frequency \omega')
ylabel('Magnitude |Y|')
axis([omegamin omegamax 0 1.3]); 
% (e) compute the inverse Fourier transform y(t)
y = iftrans(Y,Omega,t);
yreal = real(y);
z = yreal - 1
subplot(3,2,5)
plot(t,z,t,u,'--');
grid
ylabel('demodulated signal')
title('z(t) = y(t) - |Y(0)|');
legend('z(t)','u(t)');
axis([0 1 -3 3]);


