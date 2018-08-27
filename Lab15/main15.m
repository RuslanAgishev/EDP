%%% Laboratory work 13
%%% Joint assimilation of navigation data coming from different sources
%%% Group 5: Andrei Chemikhin, Ruslan Agishev, Valery Nevzorov
% Skoltech, 2017
close all
clear
% trajectory generation
addpath('Matlab')
load fi
load ro

load Image1
img1 = Dif;
load Image2
img2 = Dif;
load Image3
img3 = Dif;
load Image4
img4 = Dif;
load borders1
bds1 = borders;
load borders2
bds2 = borders;
load borders3
bds3 = borders;
load borders4
bds4 = borders;
%clear Dif
%clear borders

limits = [-100, 300];
% img1 = setlim(img1, limits);
% img2 = setlim(img2, limits);
% img3 = setlim(img3, limits);
% img4 = setlim(img4, limits);

figure
imshow(img1, [-100,300])
colormap(gca,'jet')

figure
imshow(img2,[-100,300])
colormap(gca,'jet')

figure
imshow(img3,[-100,300])
colormap(gca,'jet')

figure
imshow(img4, [-100,300])
colormap(gca,'jet')

% find angles in boundaries, also produce indecees for futher processing
[fi1,i1] = find_angle(fi,ro,bds1);
[fi2,i2] = find_angle(fi,ro,bds2);
[fi3,i3] = find_angle(fi,ro,bds3);
[fi4,i4] = find_angle(fi,ro,bds4);

figure
plot(fi1)
hold on
plot(fi2)
hold on
plot(fi3)
hold on
plot(fi4)
legend('fi1','fi2','fi3','fi4')
grid on
title('Ranges of angle')

% intensities from imgages using indecees, that correspond to angles
I1 = img1(i1);
I2 = img2(i2);
I3 = img3(i3);
I4 = img4(i4);

figure
plot(fi1,I1)
grid on
title('Intensity from angle')
xlim([fi1(1),fi1(end)])
% ylim(limits)
xlabel('fi1')
ylabel('I1')

figure
plot(fi2,I2)
grid on
title('Intensity from angle')
xlim([fi2(1),fi2(end)])
% ylim(limits)
xlabel('fi2')
ylabel('I2')

figure
plot(fi3,I3)
grid on
title('Intensity from angle')
xlim([fi3(1),fi3(end)])
% ylim(limits)
xlabel('fi3')
ylabel('I3')

figure
plot(fi4,I4)
grid on
title('Intensity from angle')
xlim([fi4(1),fi4(end)])
xlabel('fi4')
ylabel('I4')


% smoothed intensities
I1_sm = runningmean(I1,fi1, pi/16);
I2_sm = runningmean(I2,fi2, pi/16);
I3_sm = runningmean(I3,fi3, pi/16);
I4_sm = runningmean(I4,fi4, pi/16);

figure
plot(fi1,I1_sm)
grid on
title('Smoothed Intensity from angle')
xlim([fi1(1),fi1(end)])
xlabel('fi1')
ylabel('I1')

figure
plot(fi2,I2_sm)
grid on
title('Smoothed Intensity from angle')
xlim([fi2(1),fi2(end)])
xlabel('fi2')
ylabel('I2')

figure
plot(fi3,I3_sm)
grid on
title('Smoothed Intensity from angle')
xlim([fi3(1),fi3(end)])
xlabel('fi3')
ylabel('I3')


figure
plot(fi4,I4_sm)
grid on
title('Smoothed Intensity from angle')
xlim([fi4(1),fi4(end)])
xlabel('fi4')
ylabel('I4')

% removing of intensity in angle range [2,4] and I<0
% Removing pixels from the analysis that correspond to polar angles from 2 to 4 radians.
% This corresponds to direction toward northwest. There is no propagation of EUV wave
% front toward this direction due to interaction with coronal hole.
N = length(I1_sm);
Il1 = I1_sm(1:sum(fi1<2));
Ir1 = I1_sm( (N-sum(fi1>4)+1) : N);
I1_sm = [Il1, Ir1];

N = length(I2_sm);
Il2 = I2_sm(1:sum(fi2<2));
Ir2 = I2_sm( (N-sum(fi2>4)+1) : N);
I2_sm = [Il2, Ir2];

N = length(I3_sm);
Il3 = I3_sm(1:sum(fi3<2));
Ir3 = I3_sm( (N-sum(fi3>4)+1) : N);
I3_sm = [Il3, Ir3];

N = length(I4_sm);
Il4 = I4_sm(1:sum(fi4<2));
Ir4 = I4_sm( (N-sum(fi4>4)+1) : N);
I4_sm = [Il4, Ir4];

I1 = negative2zero(I1);
I2 = negative2zero(I2);
I3 = negative2zero(I3);
I4 = negative2zero(I4);

I1_sm = negative2zero(I1_sm);
I2_sm = negative2zero(I2_sm);
I3_sm = negative2zero(I3_sm);
I4_sm = negative2zero(I4_sm);

% Intensities with nonzero elements
figure
plot(fi1,I1)
xlim([fi1(1),fi1(end)])
title('Intensity with nonzero values')
xlabel('fi1')
ylabel('I1')
grid on

figure
plot(fi2,I2)
xlim([fi2(1),fi1(end)])
title('Intensity with nonzero values')
xlabel('fi2')
ylabel('I2')
grid on

figure
plot(fi3,I3)
xlim([fi3(1),fi3(end)])
title('Intensity with nonzero values')
xlabel('fi3')
ylabel('I3')
grid on

figure
plot(fi4,I4)
xlim([fi4(1),fi4(end)])
title('Intensity with nonzero values')
xlabel('fi4')
ylabel('I4')
grid on

% Coordinates of intensity centers
jc1 = intenscenter(I1);
jc2 = intenscenter(I2);
jc3 = intenscenter(I3);
jc4 = intenscenter(I4);

% Polar angles of intensity centers
fic1 = fi1(jc1);
fic2 = fi2(jc2);
fic3 = fi3(jc3);
fic4 = fi4(jc4);

fic = [fic1 fic2 fic3 fic4];

figure
plot(1:length(fic),fic)
grid on
title('Angular velocity of EUV wave in the solar corona')
xlabel('time')
ylabel('angle [rad]')

% Changing of the angle of EUV wave propagation for two sequent images
dfi = [(fic2-fic1), (fic3-fic2), (fic4-fic3)];
display('Changing of the angle of EUV wave propagation for two sequent images:')
display(strcat('From img1 to img2: ',num2str(dfi(1))));
display(strcat('From img2 to img3: ',num2str(dfi(2))));
display(strcat('From img3 to img4: ',num2str(dfi(3))));

