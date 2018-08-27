% Part 1
% trajectory generation
close all;
clear;
N = 5000000;
T=1;
v1=1;
sigmaA=3;
sigmaN=10;
x1=5;
q = 6;
t=1:N;
[x, z] = trajgen_acc(x1, sigmaN, sigmaA, N, T, v1, q);

figure(1)
plot(t,x, t,z)
xlim([t(1), 10])
ylim([x(1), 100])

[sA,sN,qz] = getstat(z,T);
display('Estimated parameters of noise and bias:');
display(strcat('sA=', num2str(sA)));
display(strcat('sN=', num2str(sN)));
display(strcat('qz=', num2str(qz)));

display('Real parameters of noise and bias:');
display(strcat('sigmaA=', num2str(sigmaA)));
display(strcat('sigmaN=', num2str(sigmaN)));
display(strcat('q=', num2str(q)));

% Part 2
N = 200;
[x, z] = trajgen_acc(x1, sigmaN, sigmaA, N, T, v1, q);
% state space - form of equations
[F,G,H] = state_space(T);
% initial covariance matrix
P0 = [1e10 0; 0 1e10];
X0 = [2;0];
R = sN^2;
Q = G*G'*sA^2;

[~,~,Xfl,Pfl,K] = kalman_filter_bias(X0,P0,F,Q,H,R,G,z,qz);
p = nan(1,N);
for i=1:(N-1)
    p(i) = sqrt(Pfl{i}(1,1));
end

t=1:N;
figure(2)
plot(t,x, t,z,':', t,Xfl(1,:));
xlim([t(1), 10])
ylim([x(1), 100])
legend('real', 'measurements', 'filtr')

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
    [~,~,Xfl_{i},~,~] = kalman_filter_bias(X0,P0,F,Q,H,R,G,Z{i},qz);
    xfl{i} = Xfl_{i}(1,:);
end

fe = final_error(xfl, X);

figure(3)
plot(t,fe, t,p);
legend('final error', 'standart deviation');
ylabel('Final error')
xlabel('Time step')
ylim([0,80])
title('Comparison of errors')
grid on;
