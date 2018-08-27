function [Id, Iv] = getindic(z, x)
Id = sum((z-x).^2);
N = length(x);
Iv = 0;
for j=1:(N-2)
   temp = (x(j+2)-2*x(j+1)+x(j))^2;
   Iv = Iv + temp;
end
end