w = {[0,0]; [-2,3]; [4,2]};
sigmaN = 0.5;

x = [w{1}(1):(w{2}(1)-w{1}(1))/100:w{2}(1) w{2}(1):(w{3}(1)-w{2}(1))/100:w{3}(1)];
y = [w{1}(2):(w{2}(2)-w{1}(2))/100:w{2}(2) w{2}(2):(w{3}(2)-w{2}(2))/100:w{3}(2)];

zx = nan(1,N);
zy = nan(1,N);
N = length(x);
for i=1:N
    n = randn(1)*sigmaN;
    zx(i) = x(i) + n;
    zy(i) = y(i) + n;
end

plot(x,y)
hold on
plot(zx,zy)
xlabel('X')
ylabel('Y')