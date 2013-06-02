function [ df ] = derivative( f, m )
%to get the derivative you have to dived df/dt where dt = t(2)-t(1)

s = (-1).*swt(f,m,'haar');

df = C(m).*s(m,:);

%the haar wavelet dose not start at -0.5 and ends at 0.5 (level 1), therefor
% df has to bee shifted.
df = circshift(df,[0,2^(m-1)]); 

end

