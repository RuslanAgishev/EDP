function [D,b] = cartesian2polar(x,y)
D = sqrt(x.^2+y.^2);
b = atan(x./y);
end