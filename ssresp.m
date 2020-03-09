function yss = ssresp(num,den,t,u,nmax)

% ssresp: steady-state response to a continuous periodic input
%
% yss = ssresp(num,den,t,u,nmax)
%
% input arguments:
%	numerator coefficient vector num
%	denominator coefficient vector den
%		both for transfer function H(s)
%		coefficients ordered in descending order 
%	time vector t corresponding to 
%		one time period: ts <= t <= tf
%	input time function vector u 
%		corresponding to time vector t
%	maximum index of Fourier coefficients nmax
%
%	period will be computed by T = tf - ts
%
% output arguments:
%	steady-state output time function vector yss 
%		corresponding to time vector t
% if no output argument is specified, dssresp will
% present a graph of input and ss output against time t
%			
% Example: Steady-state response to a half-rectified sinusoid 
%	of period 1/60 where H(s) = 1/(1+.04*s)
%	
%	T = 1/60;	
%	m = 200; % no of discrete intervals for the period
%		 % m should be a multiple of 2
%	t = [0:T/m:T];
%	thalf = [0:T/m:T/2];
%	u = [sin(2*pi*thalf/T) zeros(1,m/2)];
%	num = [1];
%	den = [.01 1];
%	nmax = 10;
%	ssresp(num,den,t,u,nmax)

error(nargchk(5,5,nargin));
lennum = length(num);
lenden = length(den);
m = length(t);
if (m ~= length(u))
	error('Vectors, u and t, must be of the same length')
end
T = max(t) - min(t);
if (T <= 0) 
	error('Period, T=max(t)-min(t), must be positive')
end
if (nmax < 0) 
	error('Maximum index, nmax, must be non-negative')
end

% Compute Fourier coefficients U of the input
omega1 = 2*pi/T;
n = 0;
	Uzero = trapz(t,u)/T;
if (nmax > 0) 
	for n=1:nmax
		integrand = u.*exp(-i*omega1*n*t);
		Upos(n) = trapz(t,integrand)/T;
		omegapos(n) = omega1*n;
	end;
end

% Compute the coefficients Y of the steady-state output 
n = 0;
	Hzero = num(lennum)/den(lenden);
if (nmax > 0) 
	powernum = fliplr([0:lennum-1]);
	powerden = fliplr([0:lenden-1]);
	for n=1:nmax
		s = i*omega1*n;
		svectnum = s.^powernum;
		svectden = s.^powerden;
		Hpos(n) = (svectnum*num')/(svectden*den');
	end;
end
Yzero = Hzero*Uzero;
if( nmax > 0)
	Ypos = Hpos.*Upos;
end

% Reconstruct the steady-state output y
for l=1:m
	time = t(l);
	y(l) = Yzero;
	if (nmax > 0) 
		y(l) = y(l)+2*real(Ypos*exp(-i*omegapos*time)');
	end;
end

if nargout==0,		% If no output arguments, plot graph
	plot(t, u,':')
	firsthalf = 'Time t     input u: dotted line    ';
	lastthalf = 'output y_{ss}: solid line';
	wholelabel = [firsthalf lastthalf];
	xlabel(wholelabel)
	ylabel('Input u and Steady-state Output y_{ss}')
	hold on
	plot(t, y,'-')
	v = axis;
	axis([min(t),max(t),v(3),v(4)])
	hold off
        return 
end
yss = y;