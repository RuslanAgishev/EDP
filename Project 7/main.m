% Project 7
% Tracking of a maneuvering vehicle

% trajectory generation
close all;
clear;
addpath('data')
load Z

T = 1;
sigmaA = 0.1;
sigmaN = 10;

X0 = zeros(4,1);
x1 = X0(1);
y1 = X0(3);
P0 = 10^5*eye(4);

[F,G,H] = state_space(T);
Q = G*G'*sigmaA^2;
R = [sigmaN^2 0; 0 sigmaN^2];

[Xpr,Ppr,Xfl,Pfl,K,V] = kalman_filter(X0,P0,F,H,R,Q,Z, sigmaN);

zx = Z(1,:);
zy = Z(2,:);

xfl = Xfl(1,:);
yfl = Xfl(3,:);

xpr = Xpr(1,:);
ypr = Xpr(3,:);

vx = V(1,:);
vy = V(2,:);

M = 13;
vx_sm = runningmean(vx,M);
vy_sm = runningmean(vy,M);

figure
plot(zx,zy,':', xfl,yfl)
grid on
title('Cartesian coordinates')
xlabel('x')
ylabel('y')
legend('measurements', 'filtered')

figure
plot(xpr)
hold on
plot(xfl)
grid on
title('Estimations of coordinate X')
xlabel('time')
ylabel('X')
legend('prediction', 'filtration')

figure
plot(ypr)
hold on
plot(yfl)
grid on
title('Estimations of coordinate Y')
xlabel('time')
ylabel('Y')
legend('prediction', 'filtration')

figure
title('Residual Vx = zx - xm')
plot(vx,':')
hold on
plot(vx_sm)
grid on
legend('measured','smoothed')
ylabel('Vx')
xlabel('time')

figure
title('Residual Vy = zy - ym')
plot(vy,':')
hold on
plot(vy_sm)
legend('measured','smoothed')
grid on
ylabel('Vy')
xlabel('time')

% determine suitable sigmaN-scale
figure
plot(abs(vy_sm))
hold on
plot(0.02*sigmaN*ones(1,length(vy_sm)))
plot(0.01*sigmaN*ones(1,length(vy_sm)))
plot(0.005*sigmaN*ones(1,length(vy_sm)))
plot(abs(vx_sm))
grid on
xlabel('time')
ylabel('residual')
legend('|zy-ym|', '0.02 sigma_N','0.01 sigma_N', '0.005 sigma_N','|zx-xm|')

scale = 0.01;
[~,~,Xfl_imp,Pfl_imp,~,V_imp] = kalman_filter(X0,P0,F,H,R,Q,Z, sigmaN,scale,[vx_sm; vy_sm]);

xfl_imp = Xfl_imp(1,:);
yfl_imp = Xfl_imp(3,:);

figure
plot(zx,zy,':', xfl_imp,yfl_imp, xfl,yfl)
grid on
title('Improved filtration')
xlabel('x')
ylabel('y')
legend('measure','improved', 'filtered')

figure
title('Y-coordinate')
plot(zy,':')
hold on
plot(yfl_imp)
hold on
plot(yfl)
grid on
legend('measure','improved', 'filtered')
xlabel('time')
ylabel('y')

figure
title('X-coordinate')
plot(zx,':')
hold on
plot(xfl_imp)
hold on
plot(xfl)
grid on
legend('measure','improved', 'filtered')
xlabel('time')
ylabel('x')


