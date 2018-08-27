function [Id_xb,Iv_xb, Id_r,Iv_r] = optindic(e1, z, M)
r = runningmean(z, M);
alpha = 2/(M+1);
e = expmean(e1, alpha, z);
xb = expmeanBack(alpha, e);

[Id_xb, Iv_xb] = getindic(z,xb);
[Id_r, Iv_r] = getindic(z,r);
end