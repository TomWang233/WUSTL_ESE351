% Chenyang(Tom) Wang 11/20/2017
% PS10 Part3
clf, clear all
% script for graphing the partial sum
T = 2;
n = 20000;
mvec = [0 1 2 3];
u_1 = [ones(1,n/4) -(ones(1,n/2)) ones(1,n/4) 1];
figure(1)
pfserie(u_1,T,mvec);
% script for graphing the steady-state output	
t = [0:T/n:T];
num = [pi];
den = [1/(pi^2) 2/pi 2 pi];
nmax = 3;
figure(2)
ssresp(num,den,t,u_1,nmax);
grid
axis([0 2 -1.2 1.2]);
title('yss when ¦Á=1');
% script for graphing gain against ¦Ø
omax = 20;
omega = -omax:.001:omax;
omegarangemin = -5*pi;
omegarangemax = 5*pi;
outputmin = 0;
outputmax = 1.2;
gain = (sqrt(1+(omega.^6/(pi^6)))).^-1;
figure(3)
plot(omega,gain);
grid
ylabel('output gain')
xlabel('omega')
title('gain against omega ')
axis([omegarangemin omegarangemax outputmin outputmax])
% script for graphing the steady-state output with updated aplha value
num_1 = [pi*((pi*sqrt(2))/4)];
nmax = 40;
figure(4)
ssresp(num_1,den,t,u_1,nmax);
grid
title('yss with new ¦Á value')
axis([0 2 -1.2 1.2]);