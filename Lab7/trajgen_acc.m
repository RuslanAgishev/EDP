function [x, z, v] = trajgen_acc(x1, sigmaN, sigmaA, N, T, v1)
% generation of trajectory, x - real one, z - measurements
x = zeros(1,N);
a = zeros(1,N);
z = zeros(1,N);
a(1) = randn(1) * sigmaA;
x(1) = x1;
v(1) = v1;
for i=2:N
    a(i) = randn(1) * sigmaA;
    n = randn(1) * sigmaA;
    v(i) = v(i-1) + a(i-1)*T;
    x(i) = x(i-1) + v(i-1)*T + a(i-1)*T^2/2;
    z(i) = x(i) + sigmaN * randn(1);
end
end