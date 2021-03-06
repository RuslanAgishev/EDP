%%% Lab 4: Determining and removing drawbacks of exponential and running
%%% mean. Task 2
%%% Skoltech, Group 5: Valery Nevzorov, Andrei Chemikhin, Ruslan Agishev
%%% Data: sunspot - data_gropu5, surface - group1.
%%% 06.10.2017.
%% Part I
close all
clear
load data_group5

N = length(data);
year = data(:,1);
month = data(:,2);
t = year + month/12;

z = data(:,3)';

% smoothing with window M=13
M=13;
r = runningmean(z,M);

% forward exp-mean
% alpha = 2/(M+1);
alpha = 0.2;
e = expmean(z(1), alpha, z);

%backward exp-mean
xb = expmeanBack(alpha, e);
figure(1)
plot(t,z, t,r, t,xb);
xlim([year(1), year(end)]);
grid on
xlabel('Date')
ylabel('Solar activity indicies');
legend('measure', 'run', 'back');

[Id_r, Iv_r] = getindic(z, r);
[Id_xb, Iv_xb] = getindic(z, xb);

display(strcat('Id_xb-Id_r=',num2str(Id_xb-Id_r)));
display(strcat('Iv_xb-Iv_r=',num2str(Iv_xb-Iv_r)));

% As Id and Iv coefficients for backward exp-mean method are less than
% ones for running mean with window size M=13, backward exp-mean method
% provides better results with smoothing.

%% Part II
% 3D - surface
close all
clear

load noisy_surface
load true_surface
Zn = noisy_surface;
N = size(Zn,1);
Xn = 1:N;
Yn = Xn;
figure(1);
surf(Xn,Yn,Zn);
colorbar
title('Noisy surface');

Z = true_surface;
X = 1:N;
Y = X;
figure(2);
surf(X,Y,Z);
colorbar
title('Real surface');

zn = reshape(Zn, [1,N*N]);
[sw2, sn2] = getsigma(zn);
% alpha = getalpha(sw2,sn2);

alpha = 0.2;
XB = expmean2D(alpha,Zn);
figure(3);
surf(X,Y,XB);
colorbar
title('Backward-mean surface: too smoothed');

alpha = 0.5;
XB = expmean2D(alpha,Zn);
figure(4);
surf(X,Y,XB);
colorbar
title('Backward-mean surface: too noisy');

alpha = 0.335;
XB = expmean2D(alpha,Zn);
figure(5);
surf(X,Y,XB);
colorbar
title('Backward-mean surface: just right');

x = reshape(XB,[1,N^2]);
[Id,Iv] = getindic(zn, x);
display(strcat('Id=',num2str(Id)));
display(strcat('Iv=',num2str(Iv)));
display('--------');

% alpha = 0 -> Id=2396417.6358, Iv=0
% alpha = 1 -> Id=0, Iv=1960494.6406
% Optimal value of alpha ~ 0.33-0.34
% alpha = 0.335 -> Id=310208.4655, Iv=2712.9179
% alpha = 0.2 -> smoothed surface, but loss of structure
% alpha = 0.5 -> noisy graph




