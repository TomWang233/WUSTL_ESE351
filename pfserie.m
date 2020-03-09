function [g, t] = pfserie(f,T,mvec)

% pfserie: partial Fourier series of a continuous-time function
%
% [g, t] = pfserie(f,T,mvec)
%
% input arguments:	
%	time function vector f corresponding to 0 <= t < T
%	duration scalar T
%	maximum index vector for partial sum mvec
%
%	Vector mvec must consist of non-negative integers.
%	Do not supply f(T), since it is the same as f(0).
%
% output arguments:	
%	partial Fourier expansion matrix g
%	corresponding to function vector f 
%   time vector t
% if no output argument is specified, pfserie will
% present a graph of function g(t) against time t
%
% 	Each column of g corresponds to function vector f.
%	Each row of g corresponds to maximum index vector mvec.
%
% Example: partial series g0, g1, g10, g79 for 
%		a continuous-time rectangular wave
%	T = 1;
%	n = 500;
%	f = [ones(1,n/2) zeros(1,n/2)];
%	mvec = [0 1 10 79];
%	pfserie(f,T,mvec)

error(nargchk(3,3,nargin));
if (T <= 0) 
	error('Duration T must be positive'); end
lmax = length(mvec);
for l = 1:lmax
	if ( mvec(l) < 0 )
		error('Max index in mvec must be non-negative'); 
	end
end;

nmax = max(mvec);
[F,Omega,Mag,Phase] = fseries(f,T,nmax);
q = length(f);
t = [0: T/q :T - T/q];

for l = 1:lmax
	m = mvec(l);	% max index for the partial sum
	gtemp(l,:) = F(nmax+1)*ones(size(t));	% F(0) constant
	if ( m <= 0 ) ; % if m<=0 do nothing
	else
		for n = 1:m
			omega = 2*pi*n/T;
			gtemp(l,:) = gtemp(l,:) ...
			 + F(nmax-n+1)*exp(-i*omega*t) ...
			 + F(nmax+n+1)*exp(i*omega*t);
		end;
	end;
end;

if nargout==0,	% If no output arguments, plot graph
    clf
    minfandg = min([min(f) min(gtemp)]);
    maxfandg = max([max(f) max(gtemp)]);
    range = [min(t),max(t),minfandg,maxfandg];
    for l = 1:lmax
		subplot(lmax,1,l)
		plot(t,f,':')
        if (l == 1) 
         title('Time Function and Its Partial Fourier Series'); 
        end
		hold on
		plot(t,gtemp(l,:),'-')
        hold on
        plot(t,zeros(size(t)),'-.')
		axis(range)
        glabel = ['g_{' int2str(mvec(l)) '}(t)'];
		ylabel(glabel)
		hold off
    end;
    hold on
    firsthalf = 'Time t     g(t) partial Fourier series in solid line';
    lastthalf = '     f(t) time function in dotted line';
    wholelabel = [firsthalf lastthalf];
	xlabel(wholelabel)
        return 
else
	g = gtemp;
end