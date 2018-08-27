function [x,y, b,D, bm,Dm] = trajgen_acc(sigmaA, N, T, x1,y1, vx1, vy1, sigmab1,sigmab2,sigmaD)
% generation of trajectory

x = nan(1,N);
ax = nan(1,N);
ay = nan(1,N);
vx = nan(1,N);
vy = nan(1,N);
b = nan(1,N);
D = nan(1,N);
Dm = nan(1,N);
bm = nan(1,N);
y = nan(1,N);
ax(1) = randn(1) * sigmaA;
ay(1) = randn(1) * sigmaA;
x(1) = x1;
y(1) = y1;
vx(1) = vx1;
vy(1) = vy1;

D(1) = sqrt(x1^2+y1^2);
b(1) = atan(x1/y1);
    
nD = randn(1) * sigmaD;
nb1 = randn(1) * sigmab1;

Dm(1) = D(1) + nD;
bm(1) = b(1) + nb1;

for i=2:N 
    nb2 = randn(1) * sigmab2;
    
    ax(i) = randn(1) * sigmaA;
    ay(i) = randn(1) * sigmaA;
    
    vx(i) = vx(i-1) + ax(i-1)*T;
    x(i) = x(i-1) + vx(i-1)*T + ax(i-1)*T^2/2;
    
    vy(i) = vy(i-1) + ay(i-1)*T;
    y(i) = y(i-1) + vy(i-1)*T + ay(i-1)*T^2/2;
    
    D(i) = sqrt(x(i)^2+y(i)^2);
    b(i) = atan(x(i)/y(i));
    
    bm(i) = b(i) + nb2;
end

for i=3:2:(N-1)
    nD = randn(1) * sigmaD;
    nb1 = randn(1) * sigmab1;

    Dm(i) = D(i) + nD;
    bm(i) = b(i) + nb1;
end

end