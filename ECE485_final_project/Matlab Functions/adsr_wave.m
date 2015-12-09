%samples from https://www.mathworks.com/matlabcentral/newsreader/view_thread/240825

function [outF] = adsr_wave(F,L,Fs)

y = dtfs_wave(F,L,Fs,'triangle');

%modify the signal with attack, decay, sustain, release
A = linspace(0.0, 0.6, (length(y)*0.20));
D = linspace(0.6, 0.5, (length(y)*0.05));
S = linspace(0.5, 0.5, (length(y)*0.40));
R = linspace(0.5, 0.0, (length(y)*0.35));

out = [A D S R];

%match the length of the modified signal and the original
dif = length(y) - length(out);

x = cat(2,out,zeros(1,dif));

outF = y.*x;