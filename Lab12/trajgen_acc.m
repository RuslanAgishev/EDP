function [x,y, b,D, bm,Dm] = trajgen_acc(sigmaA, N, T, x1,y1, vx1, vy1, sigmab,sigmaD)
% generation of trajectory

x = zeros(1,N);
ax = zeros(1,N);
ay = zeros(1,N);
vx = zeros(1,N);
vy = zeros(1,N);
b = zeros(1,N);
D = zeros(1,N);
bm = zeros(1,N);
Dm = zeros(1,N);
y = zeros(1,N);
ax(1) = randn(1) * sigmaA;
ay(1) = randn(1) * sigmaA;
x(1) = x1;
y(1) = y1;
vx(1) = vx1;
vy(1) = vy1;

D(1) = sqrt(x1^2+y1^2);
b(1) = atan(x1/y1);
    
nD = randn(1) * sigmaD;
nb = randn(1) * sigmab;

Dm(1) = D(1) + nD;
bm(1) = b(1) + nb;

for i=2:N
    nD = randn(1) * sigmaD;
    nb = randn(1) * sigmab;
    
    ax(i) = randn(1) * sigmaA;
    ay(i) = randn(1) * sigmaA;
    
    vx(i) = vx(i-1) + ax(i-1)*T;
    x(i) = x(i-1) + vx(i-1)*T + ax(i-1)*T^2/2;
    
    vy(i) = vy(i-1) + ay(i-1)*T;
    y(i) = y(i-1) + vy(i-1)*T + ay(i-1)*T^2/2;
    
    D(i) = sqrt(x(i)^2+y(i)^2);
    b(i) = atan(x(i)/y(i));
    
    Dm(i) = D(i) + nD;
    bm(i) = b(i) + nb;
end

end