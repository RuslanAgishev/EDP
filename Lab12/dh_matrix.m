function dH = dh_matrix(xpr,ypr)
dH = zeros(2,4);
dH(1,1) = xpr/sqrt(xpr^2+ypr^2);
dH(1,3) = ypr/sqrt(xpr^2+ypr^2);
dH(2,1) = ypr/(xpr^2+ypr^2);
dH(2,3) = -xpr/(xpr^2+ypr^2);
end