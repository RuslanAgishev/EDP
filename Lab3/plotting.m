function plotting(t, X, Z, R, E)
% visualisation of results on a single figure
plot(t,X{1},'g', t,Z{1},':', t,R{1},'b', t,E{1},'r');
grid on
title(strcat('Comparison'))
xlabel('time')
ylabel('value')
legend(X{2}, Z{2}, R{2}, E{2})
end

