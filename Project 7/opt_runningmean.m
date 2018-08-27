function r = opt_runningmean(z,b)
% obtaining accurate measurements from noisy ones 
% using Optimal Running mean-method: Ar = betta*z
N = length(z);

v = (6+b)*ones(1,N);
v(1) = 1+b;
v(end) = 1+b;
v(2) = 5+b;
v(N-1) = 5+b;
A = diag(v);
v = -4*ones(1,N-1);
v(1)=-2;
v(N-1)=-2;
A = A + diag(v,-1) + diag(v,1) + diag(ones(1,N-2),-2) + diag(ones(1,N-2),2);
if isrow(z)
    z = z';
end
r = A\(b*z);

end