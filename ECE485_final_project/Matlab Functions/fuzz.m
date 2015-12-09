function y = fuzz(x, Fs)
% y=fuzzexp(x, gain, mix)
% Distortion based on an exponential function
% x - input
% gain - amount of distortion, >0->
% mix - mix of original and distorted sound, 1=only distorted
gain = 11;
mix = 1;
q = x * gain / max(abs(x));
z = sign(-q) .* (1 - exp(sign(-q).*q));
y = mix * z * max(abs(x)) / max(abs(z)) + (1-mix)*x;
y = y * max(abs(x))/max(abs(y));