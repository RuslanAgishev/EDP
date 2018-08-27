function [b, R] = regression(flux, sp)
F = flux';
N = length(sp);
R = zeros(N,4);
% b = zeros(4,1);

% construct matrix R from sunspot
R(:,1) = ones(1,N);
for i=1:N
    R(i,2:4) = [sp(i), (sp(i))^2, (sp(i))^3];
end

b = inv(R'*R) * R' * F;

end