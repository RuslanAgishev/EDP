function [N,M,T,vx1,vy1, x1,y1, sigmaD,sigmab, t, D1,b1, X0,P0, F,H] = init()
% trajectory generation
close all;
clear;
N = 26;
M = 500;
T=2;
vx1=-50;
vy1 = -45;
sigmab=0.0015;
sigmaD=50;
x1 = 3500/sqrt(2);
y1 = 3500/sqrt(2);

t=1:N;

D1 = sqrt(x1^2+y1^2);
b1 = atan(x1/y1);

X0 = [40000; -20; 40000; -20];
P0 = 10^10 * eye(4);
F = eye(4);
F(1,2) = T;
F(3,4) = T;

H = zeros(2,4);
H(1,1) = 1;
H(2,3) = 1;

end