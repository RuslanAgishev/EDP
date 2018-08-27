function smoothed = smoothing(array, m)
N = length(array);
smoothed = zeros(1,N);
smoothed(1:(m-1)/2) = mean(array(1:(m-1)/2));
smoothed(N-(m-1)/2-1:N) = mean(array(N-(m-1)/2-1:N));
for i = (m-1)/2+1 : (N-(m-1)/2)
    R = 1/(2*(m-1))*(array(i-6)+array(i+6)) + mean(array((i-5):(i+5)));
    smoothed(i) = R;
end


end