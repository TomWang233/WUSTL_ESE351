function f = iftrans(F,omega,t)

% iftrans: continuous-time inverse Fourier transform
%
% f = iftrans(F,omega,t)
%
% input arguments:	
%	frequency vector omega
%	Fourier transform F 
%		corresponding to vector omega
%	time vector t
%
% output arguments:	
%	time function vector f corresponding to vector t
% if no output argument is specified, iftrans will
% present a graph of function against time
%			
% The Fourier transform F is assumed to be zero 
% 	for the values of omega outside vector omega.
% The Fourier transform for a negative omega should be 
%	the conjugate of the Fourier transform F
%	for the corresponding positive omega; 
%	if not, time function f(t) becomes complex. 
%
% Example: inverse Fourier transform of 
%	a rectangular pulse of duration 10
%	
%	omega = -5:1/10:5;	
%	F = ones(1,101);
%	t=-3:3/100:3;
%	iftrans(F,omega,t)

error(nargchk(3,3,nargin));
n = length(t);
m = length(omega);
if (m~=length(F)) 
	error('vectors omega and F must be of the same length'); 
end
for l=1:n
	integrand = F.*exp(i*t(l)*omega);
	ftemp(l) = trapz(omega,integrand)/(2*pi);
end
if nargout==0,		% If no output arguments, plot graph
	ftemp = real(ftemp);
	plot(t,ftemp)
		grid
		xlabel('Time   t')
		ylabel('Function f(t)')
		title('Time Function')
        return 
end
f = ftemp;