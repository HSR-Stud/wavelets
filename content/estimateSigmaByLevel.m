function sigma = estimateSigmaByLevel(N, wname, level)

%generate some noise
r = randn(1,N); %generate uniform or gaussian noise
r1 = r(2:end)+r(1:end);%colored noise

%calculate sigma per level
sigma = zeros(level);
[c,L] = wavedec(r1,level,wname);
for j=1:level
    sigma(j) = median(abs(detcoef(c,L,j)))/0.6745;
end

end