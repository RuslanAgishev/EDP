function xb = expmeanBack(alpha, xf)
% implementation of exp-mean-method
% for obtaining accurate measurements from noisy
N = length(xf);
xb = zeros(1,N);
xb(N) = xf(end);
for i=(length(xf)-1):-1:1
    xb(i) = xb(i+1) + alpha*(xf(i)-xb(i+1));
end
end