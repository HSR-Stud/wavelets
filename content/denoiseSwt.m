function [ f ] = denoiseSwt(signal, K, wname, level,type)

if (strcmp(type,'soft')== 1)
    soft = 1;
else
    soft = 0;
end

[swa, swd] = swt(signal,level,wname);

%threshold
sigma = median(abs(swd(1,:))) / 0.6745; %finest scale
tau = K * sqrt(2*log(length(signal)))*sigma;

swd = sign(swd).*(abs(swd)>tau).*(abs(swd)-tau*soft);

f = iswt(swa, swd,wname);

end