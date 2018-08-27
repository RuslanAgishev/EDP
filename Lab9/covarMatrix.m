function R = covarMatrix(Dm,bm, sD, sb)
N = length(bm);
R = cell(1,N);
for i=1:N
    r = nan(2,2);
    r(1,1) = (sin(bm(i)) * sD)^2 + (Dm(i)*cos(bm(i))*sb)^2;
    r(1,2) = sin(bm(i)) * cos(bm(i)) * (sD^2-(Dm(i)*sb)^2);
    r(2,1) = r(1,2);
    r(2,2) = (cos(bm(i)) * sD)^2 + (Dm(i)*sin(bm(i))*sb)^2;
    R{i} = r;
end
end