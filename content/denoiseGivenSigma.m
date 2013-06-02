function f = denoiseGivenSigma(signal, sigma, K, wname, level,type)

if (strcmp(type,'soft') == 1)
    soft = 1;
else
    soft = 0;
end

[c,L] = wavedec(signal,level,wname);
appc = c(1:L(1));
detc = zeros(1,sum(L(2:end-1)));
for i=1:level
    %calculate threshold per level
    tau = K*sqrt(2*log(length(signal)))*sigma(level+1-i);
    %thresholding
    detc1 = c(1+sum(L(1:i)):sum(L(1:i+1)));
    detc1 = sign(detc1).*(abs(detc1)>tau).*(abs(detc1)-tau*soft);
    detc(1+sum(L(2:i)):sum(L(2:i+1))) = detc1;
end
%reconstruct the denoised signal
c = [appc, detc];
f = waverec(c,L,wname);