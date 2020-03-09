function Y = ifilter(U,omega,omegal,omegah,gain,delay)
error(nargchk(4,6,nargin)); if nargin == 4
    gain = 1;
    delay = 0;
end
if nargin == 5
    delay = 0;
end
if (omegal<0)|(omegah<0)
    error('omegal and omegah must be nonnegative');
end
if omegal > omegah
    error('omegah must be greater than omegal');
end
if gain < 0
    error('gain must be nonnegative');
end
m = length(omega); if (m~=length(U))
    error('vectors omega and U must be of the same length');
end
for l=1:m
    if ((omegal<=omega(l))&(omega(l)<=omegah))|...
            ((-omegah<=omega(l))&(omega(l)<=-omegal))
        Ytemp(l) = U(l)*gain*exp(-i*omega(l)*delay);
    else
        Ytemp(l) = 0;
    end
end
if nargout == 0,
    mag = abs(Ytemp);
    phase = angle(Ytemp);
    phase = unwrap(phase);
    subplot(2,1,1)
    plot(omega,mag)
    v = axis;
    axis([min(omega),max(omega),v(3),v(4)])
    grid
    xlabel('Frequency \omega')
    ylabel('Magnitude |H(\omega)|')
    title('Output Fourier Spectrum')
    subplot(2,1,2)
    plot(omega,phase)
    v = axis;
    axis([min(omega),max(omega),v(3),v(4)])
    grid
    xlabel('Frequency \omega')
    ylabel('Angle \angleH(\omega)')
    return
end
Y = Ytemp;