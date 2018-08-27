function e = expmean(e1, alpha, z)
% implementation of exp-mean-method
% for obtaining accurate measurements from noisy
e = zeros(1,length(z));
e(1) = e1;
for i=2:length(z)
    e(i) = e(i-1) + alpha*(z(i)-e(i-1));
end
end