function [F,Omega,Mag,Phase] = ftrans(f,t,omega)

% ftrans: Fourier transform of a continuous-time function
%
% [F,Omega,Mag,Phase] = ftrans(f,t,omega)
%
% input arguments:	
%	time vector t
%	time function f corresponding to vector t
%	non-negative frequency vector omega
%		regularly spaced starting from zero
%
% output arguments:
%	negative and positive frequency vector Omega
%	Fourier transform complex vector F
%	magnitude vector Mag
%	angle vector Phase
%		all corresponding to vector Omega
% if no output argument is specified, ftrans will
%   present a graph of time function and 
%   magnitude and angle against frequency
%			
% Time function f(t) is assumed to be zero 
%	for time t outside vector t
%
% Example: Fourier transform of a rectangular pulse 
%	of duration 10
%
%   t= -10:1/10:10;	
%   f = [ zeros(1,50) ones(1,101) zeros(1,50)];
%   omega=0:3/100:3;
%   ftrans(f,t,omega)
%   subplot(3,1,1)
%   axis([min(t),max(t),-.5,1.5])

error(nargchk(3,3,nargin));
n = length(omega);
m = length(t);
if (m~=length(f)) 
	error('vectors t and f must be of the same length'); 
end
for l=1:n
	integrand = f.*exp(-i*omega(l)*t);
	Fpos(l) = trapz(t,integrand);
end
mag = abs(Fpos);
phase = angle(Fpos);
phase = unwrap(phase);
if omega(1) == 0 
	for l=1:n-1
		Fneg(l) = conj(Fpos(n+1-l));
		omeganeg(l) = -omega(n+1-l);
		magneg(l) = mag(n+1-l);
		phaseneg(l) = -phase(n+1-l);
	end;
else
	for l=1:n
		Fneg(l) = conj(Fpos(n+1-l));
		omeganeg(l) = -omega(n+1-l);
		magneg(l) = mag(n+1-l);
		phaseneg(l) = -phase(n+1-l);
	end;
end
Omega = [omeganeg omega];
Mag = [magneg mag];
Phase = [phaseneg phase];
if nargout==0,	% If no output arguments, plot graph
	subplot(3,1,1)
        plot(t,f)
        grid
        xlabel('Time   t')
        ylabel('Time function f(t)')
        title('Time Function')
    subplot(3,1,2)
		plot(Omega,Mag)
		v = axis;
		axis([min(Omega),max(Omega),v(3),v(4)])
		grid
		xlabel('Frequency \omega')
		ylabel('Magnitude |F(\omega)|')
		title('Fourier Spectrum')
	subplot(3,1,3)
		plot(Omega,Phase)
		v = axis;
		axis([min(Omega),max(Omega),v(3),v(4)])
		grid
		xlabel('Frequency \omega')
		ylabel('Angle \angleF(\omega)')
        return 
end
F = [Fneg Fpos];