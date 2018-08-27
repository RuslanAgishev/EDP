function [x, y, D,b, Dm,bm] = trajgen(x1,y1, N, T, vx1, vy1, D1,b1, sigmaD,sigmab)
% generation of trajectory, x - real one, z - measurements
x = zeros(1,N);
y = zeros(1,N);
vx = zeros(1,N);
vy = zeros(1,N);
D = zeros(1,N);
b = zeros(1,N);
Dm = zeros(1,N);
bm = zeros(1,N);

x(1) = x1;
y(1) = y1;
vx(1) = vx1;
vy(1) = vy1;

D(1) = D1;
b(1) = b1;

Dm(1) = D1;
bm(1) = b1;
for i=2:N
    nD = randn(1) * sigmaD;
    nb = randn(1) * sigmab;
    x(i) = x(i-1) + vx(i-1)*T;
    vx(i) = vx(i-1);
    
    y(i) =y(i-1) + vy(i-1)*T;
    vy(i) = vy(i-1);
    
    D(i) = sqrt(x(i)^2+y(i)^2);
    b(i) = atan(x(i)/y(i));
    
    Dm(i) = D(i) + nD;
    bm(i) = b(i) + nb;
end
end