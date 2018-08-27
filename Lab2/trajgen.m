function [x, z] = trajgen(x1,sigmaW, sigmaN, N)
% x1 = 10;
% sigma = 16;
% N = 3000;
x = zeros(1,N);
z = zeros(1,N);
x(1) = x1;
% x(i) = x(i-1) + w(i)
for i=2:N
    w = randn(1) * sigmaW;
    n = randn(1) * sigmaN;
    x(i) = x(i-1) + w;
    z(i) = x(i) + n;
end


end