function [sA,sN,qz] = getstat(z,T)
% find qz:
N = length(z);
v = zeros(1,N);
ro = zeros(1,N);
v(3) = z(3)-2*z(2)+z(1);
for i=4:N
    v(i) = z(i)-2*z(i-1)+z(i-2);
    ro(i) = z(i)-3*z(i-2)+2*z(i-3);
end
Ev = sum(v)/(N-2);
qz = Ev/T^2;

% find variances of v and ro:
Sv = sum((v(3:N)-qz*T^2*ones(1,N-2)).^2)/(N-2);
Sro = sum((ro(4:N)-3*qz*T^2*ones(1,N-3)).^2/(N-3));
Coef = [T^4/2 6; 7*T^4/2 14];
s = Coef \ [Sv; Sro];
sA = sqrt(s(1));
sN = sqrt(s(2));

end