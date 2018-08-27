% Relationship between solar radio flux F10.7 and sunspot number
% Valeriy Nevzorov, Andrei Chemikhin, Ruslan Agishev, Skoltech, 2017

close all
load data

data = data_group5;
year = data(:,1);
month = data(:,2);
t = year + month/12;

flux = data(:,3);
sunspot = data(:,4);

figure(1)
subplot(2,1,[1,2])
plot(t,flux, t,sunspot)

xlim([year(1), year(end)])
grid on
xlabel('Date')
ylabel('Solar activity indicies')
title('Original data')
legend('Flux', 'Sunspot')

% smoothing
flux_sm = smoothing(flux, 13);
sunspot_sm = smoothing(sunspot,13);

figure(2)
subplot(2,1,[1,2])
plot(t,flux_sm, t,sunspot_sm)

xlim([year(1), year(end)])
grid on
xlabel('Date')
ylabel('Solar activity indicies')
title('Smoothed curves')
legend('Flux', 'Sunspot')

[b, R] = regression(flux_sm, sunspot_sm);

% S = sigma^2
S = degression(b, R, flux_sm);






