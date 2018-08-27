function [sw2, sn2] = getsigma(z)
N = length(z);
v = zeros(1,N-1);
p = zeros(1,N);
v = z(2:N) - z(1:N-1);
for i=3:N
    p(i) = z(i) - z(i-2);
end

v2 = v.^2;
p2 = p.^2;
Ev = sum(v2)/(N-1);
Ep = sum(p2)/(N-2);

sn2 = Ev - Ep/2;
sw2 = Ep - Ev;

end