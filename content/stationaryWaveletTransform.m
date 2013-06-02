function s = stationaryWaveletTransform(x, level, wname)
dwtmode('ppd');
s = zeros(level+1,length(x));
for i=1:level
    for j=1:(2^i)
        [c,L] = wavedec(circshift(x,[0,1-j]),level,wname);
        d = detcoef(c,L,i);
        s(i,j:2^i:end) = d;
    end
end
for j=1:(2^i)
    [c,L] = wavedec(circshift(x,[0,1-j]),level,wname);
    d = appcoef(c,L,wname);
    s(level+1,j:2^i:end) = d;
end