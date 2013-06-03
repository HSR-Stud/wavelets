function [ s ] = stationaryWaveletTransform( sig, level, wname, wFilterLen )

%pad the signal in a cyclig manner (periodic)
cycpad = length(sig);
x=zeros(1,length(sig) + cycpad);
x(1:cycpad/2) = sig(cycpad/2+1:end);
x(cycpad/2 + 1:cycpad/2+length(sig)) = sig;
x(cycpad/2+length(sig)+1:end) = sig(1:cycpad/2);

%calculate the swt
s = zeros(level+1,length(sig));
    %calculate the detail coeffs
for i=1:level
    for j=1:(2^i)
        [c,L] = wavedec(circshift(x,[0,1-j]),level,wname);
        d = detcoef(c,L,i);
        s(i,j:2^i:end) = d(cycpad/(2^i)+1:1:(length(s(i,:))/(2^i)+cycpad/(2^i)));
    end
end
    %calculate the approx coeffs
for j=1:(2^level)
    [c,L] = wavedec(circshift(x,[0,1-j]),level,wname);
    d = appcoef(c,L,wname);
    s(level+1,j:2^level:end) = d(cycpad/(2^level)+1:1:(length(s(level+1,:))/(2^level)+cycpad/(2^level)));
end

    %adjust s, that the result looks like the one of the swt
offset = 0;
for k=1:level
    offset = offset + (wFilterLen/2-1)*2^(k-1);
    s(k,:) = circshift(s(k,:),[0,-offset]);
end
s(level+1,:) = circshift(s(level+1,:),[0,-offset]);

end
