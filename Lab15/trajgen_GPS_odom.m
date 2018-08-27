function [x,y, zx,zy, zV,zTheta] = trajgen_GPS_odom(N, T, x1,y1, V,...
    sigmaA,sigmax,sigmay,sigmaV,sigmaTheta, theta)
% generation of trajectory
x = nan(1,N);
y = nan(1,N);

ax = nan(1,N);
ay = nan(1,N);

vx = nan(1,N);
vy = nan(1,N);

zx = nan(1,N);
zy = nan(1,N);

zV = nan(1,N);
zTheta = nan(1,N);

ax(1) = randn(1) * sigmaA;
ay(1) = randn(1) * sigmaA;

x(1) = x1;
y(1) = y1;
    
nx = randn(1) * sigmax;
ny = randn(1) * sigmay;
zx(1) = x(1) + nx;
zy(1) = y(1) + ny;

nV = randn(1) * sigmaV;
nTheta = randn(1) * sigmaTheta;
zV(1) = V + nV;
zTheta(1) = theta(1) + nTheta;

for i=2:N
    ax(i) = randn(1) * sigmaA;
    ay(i) = randn(1) * sigmaA;
    
    vx(i) = V*cos(theta(i-1));
    x(i) = x(i-1) + vx(i)*T + ax(i-1)*T^2/2;
    
    vy(i) = V*sin(theta(i-1));
    y(i) = y(i-1) + vy(i)*T + ay(i-1)*T^2/2;
    
    nx = randn(1) * sigmax;
    ny = randn(1) * sigmay;
    zx(i) = x(i) + nx;
    zy(i) = y(i) + ny;
    
    nV = randn(1) * sigmaV;
    nTheta = randn(1) * sigmaTheta;
    zV(i) = V + nV;
    zTheta(i) = theta(i) + nTheta;
end

end