function fe = final_error(xfl, X)
M = size(X,2);
N = length(X{1});

fe = zeros(1,N);
errun = zeros(1,M);

Er = zeros(M,N);
for traj=1:M
    Er(traj,:) = (X{traj} - xfl{traj}).^2;
end
fe = sqrt( sum(Er)/(M-1) );

