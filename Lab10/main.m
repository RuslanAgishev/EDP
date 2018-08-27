%%% Laboratory work 10
%%% Sunspot cycle reconstruction free from any constraints and assumptions
%%% Group 5: Ruslan Agishev, Andrei Chemikhin, Valery Nevzorov
%%% Skoltech, 2017

close all
clear

load('Sunspot.mat');
z = MSN(:,3);

M = 13;
r = runningmean(z,M);

b = 0.01;

r_opt = opt_runningmean(z,b);
N = length(z);
year = MSN(:,1);
month = MSN(:,2);
t = year + month/12;
figure(1)
plot(t,z,':', t,r, t,r_opt);
legend('measurements','run mean','optimal run mean')
xlim([year(1), year(end)])
xlabel('time')
ylabel('sunspot')
grid on

[Id,Iv] = getindic(z,r');
[Id_opt, Iv_opt] = getindic(z,r_opt);

display(strcat('Id-Id_opt=',num2str(Id-Id_opt)));
display(strcat('Iv-Iv_opt=',num2str(Iv-Iv_opt)));

% inverse oscilations

if (Id-Id_opt)>0 && (Iv-Iv_opt)>0
    display('Optimal running mean is better for trajectory estimation');
else
    display(strcat(num2str(M),...
        '-window size running mean is better for trajectory estimation'));
end
    