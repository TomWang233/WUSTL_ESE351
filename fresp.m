function [H,gain,phase] = fresp(num,den,omega)

% fresp: frequency response of a continuous-time system
%
% [H,gain,phase] = fresp(num,den,omega)
%
% input arguments:
%	numerator coefficient vector num
%	denominator coefficient vector den
%		both for transfer function H(s)
%		coefficients ordered in descending order 
%	non-negative frequency vector omega
%
% output arguments:
%	complex frequency response vector H
%		containing H(i*omega)
%	gain vector gain containing |H(i*omega)|
%	phase vector phase containing <H(i*omega)
%		all corresponding to vector omega
% if no output argument is specified, fresp will
% present a graph of gain and phase against frequency
%
% Example: frequency response of transfer function
%	H(s) = (s+1)/(5*s^2+s+1)
%
%	num = [1 1];
%	den = [5 1 1];
%	omega = [0: 0.01: 2];	% frequency range
%	fresp(num,den,omega)

error(nargchk(3,3,nargin));
epsilon =0.00001
powernum = fliplr([0:length(num)-1]);
powerden = fliplr([0:length(den)-1]);
for n=1:length(omega)
	s = i*omega(n);
	svectnum = s.^powernum;
	svectden = s.^powerden;
	Htemp(n) = (svectnum*num')/(svectden*den');
end;
gain = abs(Htemp);
phase = angle(Htemp);
phase = unwrap(phase);
for j = 1:length(phase)
    if phase(j) > pi 
        phase(j) = phase (j)-2*pi;
    end
    if phase(j) < -pi 
        phase(j) = phase (j)+2*pi;
    end
    if abs(gain(j)) < epsilon
        phase(j) = 0;
    end
end      
if nargout==0,	% If no output arguments, plot graph
	subplot(2,1,1)
		plot(omega,gain)
		xlabel('frequency \omega')
        ylabel('gain  |H(i\omega)|')
		v = axis;
		axis([min(omega) max(omega) v(3) v(4)]);
	subplot(2,1,2)
		plot(omega,phase)
		xlabel('frequency \omega')
        ylabel('phase (radians)  \angleH(i\omega)')
		v = axis;
		axis([min(omega) max(omega) v(3) v(4)]);
	return;
end
H = Htemp;