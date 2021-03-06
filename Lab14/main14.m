%% Laboratory work 13
%%% Joint assimilation of navigation data coming from different sources
%% Group 5: Andrei Chemikhin, Ruslan Agishev, Valery Nevzorov
% Skoltech, 2017

% trajectory generation
close all;
clear;
addpath('data for lab')
load theta
N = 500;
T = 0.05;
V = 10;
sigmaA = 1;
sigmax = 3;
sigmay = 3;
sigmaD = 50;
x1 = 0;
y1 = 0;

t=1:N;
[x,y, zx,zy] = trajgen_GPS(N, T, x1,y1, V,...
    sigmaA,sigmax,sigmay, theta);

sigmaA = 5;
[F,G,H] = state_space(T);
Q = G*G'*sigmaA^2;
R = diag([sigmax^2 sigmay^2]);
X0 = zeros(4,1);

X0(1) = zx(2);
X0(2) = (zx(2)-zx(1))/T;
X0(3) = zy(2);
X0(4) = (zy(2)-zy(1))/T;

P0 = 10^4*eye(4);

[Xpr,Ppr,Xfl,Pfl,K] = kalman_filter(X0,P0,F,Q,H,R,zx,zy);

xfl = Xfl(1,:);
yfl = Xfl(3,:);

figure
plot(x,y, xfl,yfl, zx,zy,':')
grid on
title('Cartesian coordinates')
xlabel('x')
ylabel('y')
legend('real', 'filtered', 'GPS')

% final error
% generation of M=500 realiztions of trajectories
px = nan(1,N);
py = nan(1,N);

for i=1:(N-1)
    px(i) = sqrt(Pfl{i}(1,1));
    py(i) = sqrt(Pfl{i}(3,3));
end


M=500;
x = cell(1,M);
y = cell(1,M);
zx = cell(1,M);
zy = cell(1,M);
for i=1:M
[x{i},y{i}, zx{i},zy{i}] = trajgen_GPS(N, T, x1,y1, V,...
    sigmaA,sigmax,sigmay, theta);
end

% Kalman-filtration of generated trajectories
Xfl_ = cell(1,M);
Xpr_ = cell(1,M);
xfl = cell(1,M);
yfl = cell(1,M);
xpr = cell(1,M);
ypr = cell(1,M);

for i=1:M
    [Xpr_{i},~,Xfl_{i},~,~] = kalman_filter(X0,P0,F,Q,H,R,zx{i},zy{i});
    xfl{i} = Xfl_{i}(1,:);
    yfl{i} = Xfl_{i}(3,:);
    
    xpr{i} = Xpr_{i}(1,:);
    ypr{i} = Xpr_{i}(3,:);
end

flex = final_error(xfl, x);
fley = final_error(yfl, y);

prex = final_error(xpr, x);
prey = final_error(ypr, y);

figure
plot(t,flex, t,prex, t,sigmax*ones(1,N));
legend('final error X', 'prediction error X', 'sigma_x');
ylabel('Final error X')
xlabel('Time step')
title('Comparison of errors')
grid on;

figure
plot(t,fley, t,prey, t,sigmay*ones(1,N));
legend('final error Y', 'predicted error Y', 'sigma_y');
ylabel('Final error Y')
xlabel('Time step')
title('Comparison of errors')
grid on;

%% Part II
% trajectory generation
close all;
clear;
addpath('data for lab')
load theta
N = 500;
T = 0.05;
V = 10;
sigmaA = 1;
sigmax = 3;
sigmay = 3;
sigmaV = 0.5;
sigmaTheta = 0.02;
x1 = 0;
y1 = 0;

t=1:N;
[x,y, zx,zy, zV,zTheta] = trajgen_GPS_odom(N, T, x1,y1, V,...
    sigmaA,sigmax,sigmay,sigmaV,sigmaTheta, theta);

[F,G,H] = state_space(T);
Q = G*G'*sigmaA^2;
R = diag([sigmax^2, sigmay^2, sigmaV^2, sigmaTheta^2]);

X0 = zeros(4,1);

X0(1) = zx(2);
X0(2) = (zx(2)-zx(1))/T;
X0(3) = zy(2);
X0(4) = (zy(2)-zy(1))/T;

P0 = 10^4*eye(4);

[Xpr,Ppr,Xfl,Pfl,K] = extended_kalman_filter(X0,P0,F,Q,R,zx,zy,zV,zTheta);

xfl = Xfl(1,:);
yfl = Xfl(3,:);


figure
plot(x,y, zx,zy,':', xfl,yfl)
grid on
title('Cartesian coordinates')
xlabel('x')
ylabel('y')
legend('real', 'GPS', 'filtered')


% final error
% generation of M=500 realiztions of trajectories
px = nan(1,N);
py = nan(1,N);

for i=1:(N-1)
    px(i) = sqrt(Pfl{i}(1,1));
    py(i) = sqrt(Pfl{i}(3,3));
end


M=500;
x = cell(1,M);
y = cell(1,M);
zx = cell(1,M);
zy = cell(1,M);
zV = cell(1,M);
zTheta = cell(1,M);
for i=1:M
    [x{i},y{i}, zx{i},zy{i}, zV{i},zTheta{i}] = trajgen_GPS_odom(N, T, x1,y1, V,...
    sigmaA,sigmax,sigmay,sigmaV,sigmaTheta, theta);
end

% Kalman-filtration of generated trajectories
Xfl_ = cell(1,M);
Xpr_ = cell(1,M);
xfl = cell(1,M);
yfl = cell(1,M);
xpr = cell(1,M);
ypr = cell(1,M);

for i=1:M
    [Xpr_{i},~,Xfl_{i},~,~] = extended_kalman_filter(X0,P0,F,Q,R,zx{i},zy{i},zV{i},zTheta{i});
    xfl{i} = Xfl_{i}(1,:);
    yfl{i} = Xfl_{i}(3,:);
    
    xpr{i} = Xpr_{i}(1,:);
    ypr{i} = Xpr_{i}(3,:);
end

flex = final_error(xfl, x);
fley = final_error(yfl, y);

prex = final_error(xpr, x);
prey = final_error(ypr, y);

figure
plot(t,flex, t,prex, t,sigmax*ones(1,N));
legend('final error X', 'prediction error X', 'sigma_x');
ylabel('Final error X')
xlabel('Time step')
title('Comparison of errors')
ylim([0,3.1])
grid on;

figure
plot(t,fley, t,prey, t,sigmay*ones(1,N));
legend('final error Y', 'predicted error Y', 'sigma_y');
ylabel('Final error Y')
xlabel('Time step')
title('Comparison of errors')
ylim([0,3.1])
grid on;

