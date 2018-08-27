function dH = dh_matrix(Vxpr,Vypr)
dH = zeros(4,4);
dH(1,1) = 1;
dH(2,3) = 1;
dH(3,2) = Vxpr/sqrt(Vxpr^2+Vypr^2);
dH(3,4) = Vypr/sqrt(Vxpr^2+Vypr^2);
dH(4,2) = -Vypr/(Vxpr^2+Vypr^2);
dH(4,4) = Vxpr/(Vxpr^2+Vypr^2);
end