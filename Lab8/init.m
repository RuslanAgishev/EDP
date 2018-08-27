function [N,M,T,v1,x1,sigmaA,sigmaN, F,G,H,P0,X0,R,Q, m,t] = init()
% trajectory generation
close all;
clear;
N = 200;
M=500;
T=1;
v1=1;
sigmaA=0.2;
sigmaN=20;
x1=5;

% state space - form of equations
[F,G,H] = state_space(T);
% initial covariance matrix
P0 = [10000 0; 0 10000];
X0 = [2;0];
R = sigmaN^2;
Q = G*G'*sigmaA^2;

m = 7;
t=1:N;
end