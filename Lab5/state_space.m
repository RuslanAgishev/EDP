function [F,G,H] = state_space(T)
F = [1 T; 0 1];
G = [T^2/2; T];
H = [1 0];
end