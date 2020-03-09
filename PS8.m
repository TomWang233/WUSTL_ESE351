% Chenyang(Tom) Wang 11/01/2017
% PS8 Part3
clf, clear all
%--------------------------------------------------------------------------
% Problem 9.9.1
%(b) script for sketching the partial sum
T_1 = 5;
n = 200;
t_1 = [0:1/n:T];
f_1 = [-t_1+1 -t_1+1 -t_1+1 -t_1+1 -t_1+1];
mvec = [0 1 2 5 20];
figure(1)
pfserie(f_1,T_1,mvec);
%(c) script for sketching the Fourier Spectrum
nmax_1 = 28;
figure(2);
fseries(f_1,T_1,nmax_1);
%--------------------------------------------------------------------------
% Problem 9.9.5
%(b) script for sketching the partial sum
T_2 = 20;
t = [0:T_2/n:T_2-T_2/n];
f_2 = abs(sin((pi/5)*t));
figure(3);
pfserie(f_2,T_2,mvec);
%(c) script for sketching the Fourier Spectrum
figure(4);
nmax_2 = 22;
fseries(f_2,T_2,nmax_2);

