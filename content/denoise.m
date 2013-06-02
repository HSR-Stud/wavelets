function f = denoise(signal, K, wname, level, type)
%Wavelet Decomposition
[c,L] = wavedec(signal,level,wname);

%Calculate the threshold tau
    %detcoef(c,L,1) returns the detail wavelet coeffs of the finest scale
sig = median(abs(detcoef(c,L,1)))/0.6745; %sigma
tau = K*sqrt(2*log(length(signal)))*sig; %threshold

%Denoise the signal
appc = c(1:L(1));
detc = c(L(1)+1:end);
if (strcmp(type,'soft')== 1)
    soft = 1;
else
    soft = 0;
end
    %sign(detc) returns the signum of detc (-1,0,1)
    %(abs(detc)>tau) returns 1 if true, and 0 if false
detc = sign(detc).*(abs(detc)>tau).*(abs(detc)-tau*soft);

%Reconstruction of the denoised signal
c = [appc, detc];
f = waverec(c,L,wname);