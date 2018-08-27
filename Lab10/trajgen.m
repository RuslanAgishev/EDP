function [x, z] = trajgen(x1,sigmaW, sigmaN, N)
% generation of trajectory, x - real one, z - measurements
x = zeros(1,N);
z = zeros(1,N);
x(1) = x1;
for i=2:N
    w = randn(1) * sigmaW;
    n = randn(1) * sigmaN;
    x(i) = x(i-1) + w;
    z(i) = x(i) + n;
end
end