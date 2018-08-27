%% trajectory generation
close all;
clear;
N = 200;
T=1;
v1=1;
sigmaA=0.2;
sigmaN=20;
x1=5;
q = 0.2;
t=1:N;
[x, z] = trajgen_acc(x1, sigmaN, sigmaA, N, T, v1, q);

% state space - form of equations
[F,G,H] = state_space(T);
% initial covariance matrix
P0 = [10000 0; 0 10000];
X0 = [2;0];
R = sigmaN^2;
Q = G*G'*sigmaA^2;

% non optimal filtration, don't take into account q!=0
[Xpr,Ppr,Xfl,Pfl,K] = kalman_filter(X0,P0,F,Q,H,R,z);

figure(1)
plot(t,x, t,z,':', t,Xfl(1,:));
legend('real', 'measure', 'filter');
ylabel('Coordinate')
xlabel('Time step')
xlim([0,100]);
grid on;

% final error
% generation of M=500 realiztions of trajectories
M=500;
X = cell(1,M);
Z = cell(1,M);
for i=1:M
    [X{i}, Z{i}] = trajgen_acc(x1, sigmaN, sigmaA, N, T, v1, q);
end
% Kalman-filtration of generated trajectories
Xfl_ = cell(1,M);
xfl = cell(1,M);

for i=1:M
    [~,~,Xfl_{i},~,~] = kalman_filter(X0,P0,F,Q,H,R,Z{i});
    xfl{i} = Xfl_{i}(1,:);
end

fe = final_error(xfl, X);

p = nan(1,N);
for i=1:(N-1)
    p(i) = sqrt(Pfl{i}(1,1));
end

figure(2)
plot(t,fe, t,p);
legend('1 filt step', 'standart deviation');
ylabel('Final error')
xlabel('Time step')
title('Comparison of errors')
grid on;

%% optimal filtration: take into account bias
close all;
clear;
N = 200;
T=1;
v1=1;
sigmaA=0.2;
sigmaN=20;
x1=5;
q = 0.2;
t=1:N;
[x, z] = trajgen_acc(x1, sigmaN, sigmaA, N, T, v1, q);

% state space - form of equations
[F,G,H] = state_space(T);
% initial covariance matrix
P0 = [10000 0; 0 10000];
X0 = [2;0];
R = sigmaN^2;
Q = G*G'*sigmaA^2;


% final error
% generation of M=500 realiztions of trajectories
M=500;
X = cell(1,M);
Z = cell(1,M);
for i=1:M
    [X{i}, Z{i}] = trajgen_acc(x1, sigmaN, sigmaA, N, T, v1, q);
end
% Kalman-filtration of generated trajectories
Xfl_ = cell(1,M);
xfl = cell(1,M);
Pfl = cell(1,M);
for i=1:M
    [~,~,Xfl_{i},Pfl{i},~] = kalman_filter_bias(X0,P0,F,Q,H,R,G,Z{i},q);
    xfl{i} = Xfl_{i}(1,:);
end

fe = final_error(xfl, X);

p = nan(1,N);
for i=1:(N-1)
    p(i) = sqrt(Pfl{i}(1,1));
end

figure(3)
plot(t,fe, t,p);
legend('1 filt step', 'standart deviation');
ylabel('Final error')
xlabel('Time step')
title('Comparison of errors')
grid on;
