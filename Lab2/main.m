%% Part 1
close all
N = 3000;
% N = 300
sw2 = 16;
sn2 = 8;

[x, z] = trajgen(10, sqrt(sw2), sqrt(sn2), N);


% t = 1:3000;
% plot(t(1:300), x(1:300), t(1:300), z(1:300));

[sw2, sn2] = getsigma(z);
a = getalpha(sw2,sn2);


%% Part 2
close all
N = 300;
x1 = 10;
sw2 = 28^2;
sn2 = 97^2;

[x, z] = trajgen(x1, sqrt(sw2), sqrt(sn2), N);
a = getalpha(sw2,sn2);

M = ceil( (2-a)/a );
if rem(M,2)==0
    M = M-1;
end

% estimated trajectory
r = runningmean(z,M);
t = 1:N;

e = expmean(x1, a, z);

E = {e, 'exp'};
X = {x, 'real'};
Z = {z, 'measure'};
R = {r, 'run'};

plotting(t, X, Z, R, E);






