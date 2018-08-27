function S = degression(b,R, flux_sm)
F = (R*b)';
N = length(F);
% S = sigma^2
S = 1/(N-1)* sum((flux_sm - F).^2);

end