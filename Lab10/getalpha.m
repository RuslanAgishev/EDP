function alpha = getalpha(sw2,sn2)
% obtaining parameter alpha for exp-mean method
X = sw2/sn2;
alpha = (-X + sqrt(X^2+4*X))/2;
end