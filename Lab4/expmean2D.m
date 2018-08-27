function Enew = expmean2D(alpha,Z)
N = size(Z,1);
E = zeros(N,N);
for i=1:N
    z = Z(i,:);
    e = expmean(z(1),alpha,z);
    xb = expmeanBack(alpha,e);
    E(i,:) = xb;
end
Enew = E';
for i=1:N
    z = Enew(i,:);
    e = expmean(z(1),alpha,z);
    xb = expmeanBack(alpha,e);
    Enew(i,:) = xb;
end
Enew = Enew';
end
