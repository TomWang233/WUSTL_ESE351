function [F,Omega,Mag,Phase] = fseries(f,T,nmax,epsilon,str)

% fseries: Fourier series of a continuous-time scalar function
%
% [F,Omega,Mag,Phase] = fseries(f,T,nmax,epsilon,str)
%
% input arguments:	
%	time function vector f corresponding to 0 <= t < T
%	period scalar T
%	max index of Fourier coefficients nmax
%	minimum magnitude scalar epsilon
%	unwrap control string str
%
% Do not supply f(T) since it is the same as f(0)
% If the magnitude of a Fourier coefficient is < epsilon, 
%	the corresponding angle is set to zero.
% If str is 'unwrap', the angle Phase will be unwrapped;
%	if str is any other 6-letter string, say 'wrap!!',
%	no unwrapping takes place.
% The last 2 arguments need not be supplied:
%	the default value for epsilon is 0.001;
%	the default value for str is 'wrap!!'
%	
% output arguments:	
%	Fourier coefficient complex vector F
%	magnitude vector Mag
%	angle vector Phase		
%	frequency vector Omega
%
%	where the first value F(1) of F vector is actually 
% 	the coeff F(-nmax) corresponding to the negative of 
%	the max frequency
% if no output argument is specified, fseries will
% present a graph of magnitude and angle against frequency
%			
% Time function f(t) is to be expressed in a row vector 
%	containing f(0), f(T/m), f(2*T/m), ... , f((m-1)*T/m)
%	where m = the size of row vector f
%
% Example: Fourier series of a rectangular wave 
%	of pulse duration 5 and period 10
%	
%	T = 10;	
%	m = 100; % no of discrete intervals for the period
%	% m should be a multiple of 4 for the next line
%	f = [ones(1,m/4) zeros(1,m/2) ones(1,m/4)]; % row 
%	nmax = 20;
%	epsilon = .02;
%	str = 'wrap!!';
%	fseries(f,T,nmax,epsilon,str)

error(nargchk(3,5,nargin));
if (nargin < 5) str = 'wrap!!'; end
if (nargin < 4) epsilon = 0.001; end
m = length(f);
if (T <= 0) 
	error('Period T must be positive'); end
if (nmax <= 0) 
	error('No of coefficients nmax must be positive'); 
end
if (epsilon <= 0) 
	error('Min magnitude epsilon must be positive'); 
end
if (length('wrap!!') ~= length(str)) 
	error('Control string must be of 6 letters'); 
end
fintern = [f f(1)];
t = [0:T/m:T];
omega1 = 2*pi/T;
n = 0;
	integrand = fintern;
	Fzero = trapz(t,integrand)/T;
for n=1:nmax
	integrand = fintern.*exp(-i*omega1*n*t);
	Fpos(n) = trapz(t,integrand)/T;
	omegapos(n) = omega1*n;
end
magzero = abs(Fzero);
magpos = abs(Fpos);
phasezero = angle(Fzero);
phasepos = angle(Fpos);
if ( magzero < epsilon ) phasezero = 0; end
for n = 1:nmax
	if ( magpos(n) < epsilon ) phasepos(n) = 0; end
end
if ( str == 'unwrap' ) phasepos = unwrap(phasepos); end
Fneg = fliplr(conj(Fpos));
omeganeg = -fliplr(omegapos);
magneg = fliplr(magpos);
phaseneg = -fliplr(phasepos);
Omega = [omeganeg 0 omegapos];
Mag = [magneg magzero magpos];
Phase = [phaseneg phasezero phasepos];
if nargout==0,	% If no output arguments, plot graph
    subplot(2,1,1)
        stem(Omega,Mag,'.')
        hold on
        plot(Omega,Mag,':')
        hold on
        plot(Omega,zeros(size(Omega)),'-.')
		v = axis;
		axis([min(Omega),max(Omega),v(3),v(4)])
		grid
        xlabel('Frequency \omega')
        ylabel('Magnitude |F(\omega)|')
		title('Fourier Spectrum')
     subplot(2,1,2)
	stem(Omega,Phase,'.')
        hold on
        plot(Omega,Phase,':')
        hold on
        plot(Omega,zeros(size(Omega)),'-.')
		v = axis;
		axis([min(Omega),max(Omega),v(3),v(4)])
		grid
        xlabel('Frequency \omega')
        ylabel('Angle \angleF(\omega)')
    return 
end
F = [Fneg Fzero Fpos];
