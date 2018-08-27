function [ r, x, z ] = runfromperiod(T, sigmaW, sigmaN, M)
N = 200;
x = zeros(1,N);
z = zeros(1,N);
A = zeros(1,N);

omega = 2*pi/T;
A(1) = 1;
for i=2:N
    w = randn(1) * sigmaW;
    n = randn(1) * sigmaN;
    A(i) = A(i-1) + w;
    x(i) = A(i)*sin(omega*i+3);
    z(i) = x(i) + n;
end

r = runningmean(z,M);
