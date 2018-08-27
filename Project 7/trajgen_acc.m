function [x,y,zx,zy] = trajgen_acc(sigmaA, sigmaN, N, T, x1,y1, vx1, vy1)
% generation of trajectory

x = zeros(1,N);
zx = zeros(1,N);
zy = zeros(1,N);
ax = zeros(1,N);
ay = zeros(1,N);
vx = zeros(1,N);
vy = zeros(1,N);
y = zeros(1,N);
ax(1) = randn(1) * sigmaA;
ay(1) = randn(1) * sigmaA;
x(1) = x1;
y(1) = y1;
vx(1) = vx1;
vy(1) = vy1;

for i=2:N    
    ax(i) = randn(1) * sigmaA;
    ay(i) = randn(1) * sigmaA;
    
    vx(i) = vx(i-1) + ax(i-1)*T;
    x(i) = x(i-1) + vx(i-1)*T + ax(i-1)*T^2/2;
    n = randn(1)*sigmaN;
    zx(i) = x(i) + n;
    
    vy(i) = vy(i-1) + ay(i-1)*T;
    y(i) = y(i-1) + vy(i-1)*T + ay(i-1)*T^2/2;
    zy(i) = y(i) + n;
end

end