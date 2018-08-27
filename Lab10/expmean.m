function e = expmean(e1, a, z)
% implementation of exp-mean-method
% for obtaining accurate measurements from noisy
e = zeros(1,length(z));
e(1) = e1;
for i=2:length(z)
    e(i) = e(i-1) + a*(z(i)-e(i-1));
end
end