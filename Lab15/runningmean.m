function smoothed = runningmean(I,fi, angle)
% obtaining accurate measurements from noisy ones 
% using Running mean-method: r = 1/M sum(z)


% if rem(M,2)==0
%     M = M-1;
% end
% r(1:(M-1)/2) = mean(I(1:(M-1)/2));
% r(length(I)-(M-1)/2+1 : length(I)) = mean(I(length(I)-(M-1)/2+1 : length(I)));
% for i=((M-1)/2+1) : (length(I)-(M-1)/2)
%     r(i) = 1/M*sum(I(i-(M-1)/2 : i+(M-1)/2));
% end
N = length(I);
smoothed = zeros(1,N);
smoothed( 1 : length(fi(fi<angle))+1 ) = sum(I(1:length(fi(fi<angle))));
smoothed(N-length(fi(fi<angle))+1 : N) = sum(I(N-length(fi(fi<angle))+1 : N));

for i=( length(fi(fi<angle))+2 ):(length(I) - length(fi(fi<angle)) )
    smoothed(i) = sum(I(angle2ind(angle,i,fi)));
end
end