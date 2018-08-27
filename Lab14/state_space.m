function [F,G,H] = state_space(T)
F = eye(4);
F(1,2) = T;
F(3,4) = T;
G = [T^2/2 0; T 0; 0 T^2/2; 0 T];
H = zeros(2,4);
H(1,1) = 1;
H(2,3) = 1;
end