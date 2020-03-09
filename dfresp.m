function [H,gain,phase] = dfresp(num,den,theta)

% dfresp: frequency response of a discrete-time system

% [H,gain,phase] = dfresp(num,den,theta)
%
% input arguments:
%	numerator coefficient vector num
%	denominator coefficient vector den
%		both for transfer function H(z)
%		coefficients ordered in descending order 
%	non-negative frequency vector theta
%		regularly spaced & increasing
% output arguments:
%	complex frequency response vector H
%		containing H(exp(i*theta))
%	gain vector gain containing |H(exp(i*theta))|
%	phase vector phase containing <H(exp(i*theta))
%		all corresponding to vector theta
% if no output argument is specified, dfresp will
% present a graph of gain and phase against frequency
%
% Example: frequency resonse of transfer function
%	H(z)=(z^3+2*z^2+2*z+1)/6*z^3
%
%	num = [ 1 2 2 1];
%	den = [ 6 0 0 0];
%	theta = [0: pi/100: pi];
%	dfresp(num,den,theta)

error(nargchk(3,3,nargin));
powernum = fliplr([0:length(num)-1]);
powerden = fliplr([0:length(den)-1]);
for n=1:length(theta)
	z = exp(i*theta(n));
	svectnum = z.^powernum;
	svectden = z.^powerden;
	Htemp(n) = (svectnum*num')/(svectden*den');
end;
gain = abs(Htemp);
phase = angle(Htemp);
phase = unwrap(phase);
if nargout==0,	% If no output arguments, plot graph
	subplot(2,1,1)
		plot(theta,gain)
		xlabel('frequency \theta')
        ylabel('gain |H(e^{i\theta})|')
        v = axis;
		axis([min(theta) max(theta) v(3) v(4)]);
	subplot(2,1,2)
		plot(theta,phase)
        xlabel('frequency \theta')
        ylabel('phase (radians) \angleH(e^{i\theta})')
		v = axis;
		axis([min(theta) max(theta) v(3) v(4)]);
	return;
end
H = Htemp;
