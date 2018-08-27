function r = runningmean(z,M)
% r = 1/M sum(z)
r = zeros(1,length(z));
r(1:(M-1)/2) = mean(z(1:(M-1)/2));
r(length(z)-(M-1)/2+1 : length(z)) = mean(z(length(z)-(M-1)/2+1 : length(z)));

for i=((M-1)/2+1) : (length(z)-(M-1)/2)
    r(i) = 1/M*sum(z(i-(M-1)/2 : i+(M-1)/2));
end

end