x = [ 0 0 0 0 1 2 3 4 0 0 0 0]; % Signal

%Wavelet Decomposition
    %Analysefiltercoeffizent
h = 1/(4*sqrt(2)) * [1+sqrt(3), 3+sqrt(3), 3-sqrt(3), 1-sqrt(3)]; %A (Lowpass)
g = fliplr(h) .* [ 1 -1 1 -1]; %D (Highpass)
    %Lowpassfiltering
t = conv(x,h); % convolution signal with filtercoeff A
u1 = t(2:2:end); % downsamling
    %Highpassfiltering
t = conv(x,g); % convolution signal with filtercoeff D 
v1 = t(2:2:end); % downsamling
    %dose the same as wavedec
[C,L] = wavedec(x,1,h,g);

%Wavelet Reconstruction
    %Synthesefiltercoeffizient
htilde = fliplr(h); %A_tilde
gtilde = fliplr(htilde) .* [-1 1 -1 1]; %D_tilde
    %Up-Sampling of aprox coeff u1
s = zeros(1,14);
s(2:2:end) = u1;
    %Up-Sampling of det coeff v1
t = zeros(1,14);
t(2:2:end) = v1;
    %Filtering of the upsampled signals and adding them up
u0 = conv(s,htilde) + conv(t,gtilde);
    %dose the same as
u0 = waverec(C,L,htilde,gtilde);