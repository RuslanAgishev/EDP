function [V, theta] = cartesian2polar(Vx,Vy)
V = sqrt(Vx.^2+Vy.^2);

if Vx>0
    theta = atan(Vy./Vx);
elseif Vy>0 && Vx<0
    theta = atan(Vy./Vx) + pi;
elseif Vy<0 && Vx<0
    theta = atan(Vy./Vx) - pi;
elseif Vy>0 && Vx==0
    theta = pi/2;
elseif Vy<0 && Vx==0
    theta = -pi/2;
end

end