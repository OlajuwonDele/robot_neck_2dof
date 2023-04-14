clear variables

%100g, L= 200
press100_L200 = [0.25, 0.27, 0.3, 0.325, 0.35, 0.375, 0.4, 0.425, 0.45 ,0.475, 0.5];
roll100_L200 = [60,56,6,2,2,3,2,2,3,1,1];
pitch100_L200 = [-32,-31,-5,0,0,0,0,0,0,0,0];
%
%200g, L= 200
press200_L200 = [0.3,0.325,0.35,0.375,0.4,0.425,0.45,0.475,0.5];
roll200_L200 = [60,10,8,5,7,5,5,2,3];
pitch200_L200 = [-32,-6,-6,-2,0,0,0,0,0];
%
%300g, L= 200
press300_L200 = [0.325,0.35,0.375,0.4,0.45,0.475,0.5];
roll300_L200 = [58,61,9,6,6,6,4];
pitch300_L200 = [-28,-31,-7,1,0,0,0];
%

%100g, L= 190
press100_L190 = [0.3,0.325,0.35,0.375,0.4,0.425,0.45,0.475,0.5];
roll100_L190 = [3,4,4,3,2,0,0,0,0];
pitch100_L190 = [0,0,0,0,0,0,0,0,0];
%

%200g, L= 190
press200_L190 = [0.3,0.325,0.35,0.375,0.4,0.425,0.45,0.475,0.5];
roll200_L190 = [5,6,6,5,4,2,0,0,0];
pitch200_L190 = [0,0,0,0,0,0,0,0,0];
%
%300g, L= 190
press300_L190 = [0.3,0.325,0.35,0.375,0.4,0.425,0.45,0.475,0.5];
roll300_L190 = [39,46,46,44,8,4,3,1,1];
pitch300_L190 = [-29,-29,-32,-30,0,0,0,0,0];
%



%100g, OR = 2
press100_OR_2 = [0.3,0.325,0.35,0.375,0.4,0.425,0.45,0.475,0.5];
roll100_OR_2 = [2,0,0,0,0,0,0,0,0];
pitch100_OR_2 = [9,1,2,0,0,0,0,0,0];%

%200g, OR = 2
press200_OR_2 = [0.3,0.325,0.35,0.375,0.4,0.425,0.45,0.475,0.5];
roll200_OR_2 = [1,8,7,3,0,5,6,5,6];
pitch200_OR_2 = [7,63,61,67,1,62,65,61,62];%

%300g, OR = 2
press300_OR_2 = [0.3,0.325,0.35,0.375,0.4,0.425,0.45,0.475,0.5];
roll300_OR_2 = [8,8,5,3,5,4,6,5,6];
pitch300_OR_2 = [61,60,61,70,64,64,63,64,65];%

r = [0; 0 ; 0.11];
F1 = [9.81*0.180;0; 0];
F2 = [9.81*0.280;0;0];
F3 = [9.81*0.380;0; 0];

for i = 1:1:size(pitch100_OR_2,2)
[y1(i) pitch100_OR_2global(i), roll100_OR_2global(i)] = dh_run(pitch100_OR_2(i),roll100_OR_2(i));
end

for i = 1:1:size(pitch200_OR_2,2)
[y2(i) pitch200_OR_2global(i), roll200_OR_2global(i)] = dh_run(pitch200_OR_2(i),roll200_OR_2(i));
end

for i = 1:1:size(pitch300_OR_2,2)
[y3(i) pitch300_OR_2global(i), roll300_OR_2global(i)] = dh_run(pitch300_OR_2(i),roll300_OR_2(i));
end

    


figure(4)
hold on
h = plot(press100_L190,roll100_L190, press100_L200, roll100_L200, press200_L190,roll200_L190,press200_L200, roll200_L200,	press300_L190,roll300_L190,press300_L200, roll300_L200,'LineWidth',3)
colors = {[1 0 0],[0 1 0],[0 0 1],[0.8500 0.3250 0.0980] ,[0.4940 0.1840 0.5560],[0 0 0]};
[h(1).Color h(2).Color h(3).Color h(4).Color h(5).Color h(6).Color] = colors{:};
grid on;
fontsize(gcf,scale=1.7)
ylim("auto")
xlim("auto")
xlabel('Pressure [MPa]'), ylabel('\theta_{r} [\circ]')
legend('L = 190 mm, Moment = 0.1942 Nm', 'L = 200 mm, Moment = 0.1942 Nm', 'L = 190 mm, Moment = 0.3021 Nm', 'L = 200 mm, Moment = 0.3021 Nm', 'L = 190 mm, Moment = 0.4101 Nm', 'L = 200 mm, Moment = 0.4101 Nm')
title('Compliance Test 1')
hold off

figure(5)
hold on
h = plot(press100_L190,pitch100_L190, press100_L200, pitch100_L200, press200_L190,pitch200_L190,press200_L200, pitch200_L200,	press300_L190,pitch300_L190,press300_L200, pitch300_L200,'LineWidth',3)
colors = {[1 0 0],[0 1 0],[0 0 1],[0.8500 0.3250 0.0980] ,[0.4940 0.1840 0.5560],[0 0 0]};
[h(1).Color h(2).Color h(3).Color h(4).Color h(5).Color h(6).Color] = colors{:};
grid on; 
fontsize(gcf,scale=1.7)
xlim("auto")
ylim("auto")
xlabel('Pressure [MPa]'), ylabel('\theta_{p} [\circ]')
legend('L = 190 mm, Moment = 0.1942 Nm', 'L = 200 mm, Moment = 0.1942 Nm', 'L = 190 mm, Moment = 0.3021 Nm', 'L = 200 mm, Moment = 0.3021 Nm', 'L = 190 mm, Moment = 0.4101 Nm', 'L = 200 mm, Moment = 0.4101 Nm','Location','southeast')
title('Compliance Test 1')
hold off


%%

figure(6)
hold on
h = plot(press100_OR_2,roll100_OR_2, press200_OR_2, roll200_OR_2, press300_OR_2, roll300_OR_2,'LineWidth',3 )
colors = {[1 0 0],[0 1 0],[0 0 1]};
[h(1).Color h(2).Color h(3).Color] = colors{:};
grid on;
fontsize(gcf,scale=1.7)
xlim("auto")
xlabel('Pressure [MPa]'), ylabel('\theta_{r} [\circ]')
legend('Moment = 0.1942 Nm', 'Moment = 0.3021 Nm', 'Moment = 0.4101 Nm')
title('Compliance Test 2: Local Coordinate System')
hold off

figure(7)
hold on
fontsize(gcf,scale=1.7)
h = plot(press100_OR_2,pitch100_OR_2, press200_OR_2, pitch200_OR_2, press300_OR_2, pitch300_OR_2,'LineWidth',3 )
colors = {[1 0 0],[0 1 0],[0 0 1]};
[h(1).Color h(2).Color h(3).Color] = colors{:};
grid on;
xlim("auto")
xlabel('Pressure [MPa]'), ylabel('\theta_{p} [\circ]')
legend('Moment = 0.1942 Nm', 'Moment = 0.3021 Nm', 'Moment = 0.4101 Nm')
title('Compliance Test 2: Local Coordinate System')
hold off

figure(8)
hold on
h = plot(press100_OR_2,roll100_OR_2global, press200_OR_2, roll200_OR_2global, press300_OR_2, roll300_OR_2global,'LineWidth',3 )
colors = {[1 0 0],[0 1 0],[0 0 1]};
[h(1).Color h(2).Color h(3).Color] = colors{:};
grid on;
xlim("auto")
fontsize(gcf,scale=1.7)
xlabel('Pressure [MPa]'), ylabel('\theta_{r} [\circ]')
legend('Moment = 0.1942 Nm', 'Moment = 0.3021 Nm', 'Moment = 0.4101 Nm')
title('Compliance Test 2: Global Coordinate System')
hold off

figure(9)
hold on
h = plot(press100_OR_2,pitch100_OR_2global, press200_OR_2, pitch200_OR_2global, press300_OR_2, pitch300_OR_2global,'LineWidth',3 )
colors = {[1 0 0],[0 1 0],[0 0 1]};
[h(1).Color h(2).Color h(3).Color] = colors{:};
grid on;
fontsize(gcf,scale=1.7)
xlim("auto")
xlabel('Pressure [MPa]'), ylabel('\theta_{p} [\circ]')
legend('Moment = 0.1942 Nm', 'Moment = 0.3021 Nm', 'Moment = 0.4101 Nm')
title('Compliance Test 2: Global Coordinate System')
hold off

DHConvention(0, 0, 0, 74)

%%
function [yglobal, pglobal, rglobal] = dh_run(p,r)
L_joint = 67;
L_support = 184; 

            
origin = [0;0;0;1];


pitch = p;
roll = r;


ujoint_aP= 0;
ujoint_alphaP = pitch;
ujoint_dP = L_support;
ujoint_thetaP = 0;

ujoint_aR= 0;
ujoint_alphaR = roll;
ujoint_dR = 0;
ujoint_thetaR = 90;

tujoint = DHConvention(ujoint_aP, ujoint_alphaP, ujoint_dP, ujoint_thetaP) * DHConvention(ujoint_aR, ujoint_alphaR, ujoint_dR, ujoint_thetaR);
pujoint = tujoint * origin;
pujoint = pujoint(1:3);

c_a = 0;
c_alpha = 90;
c_theta = -90;
c_d = L_joint;

tc = DHConvention(c_a, c_alpha, c_d, c_theta);
talpha90 = DHConvention(0, -90, 0, 0);
tomega = DHConvention(0, 0, 0, 74);
T_rotated = tujoint * tc * talpha90 * tomega;
yglobal = rad2deg(atan(T_rotated(2,1)/T_rotated(1,1)));
pglobal = rad2deg(atan(-T_rotated(3,1)/ sqrt(T_rotated(3,2)^2 + T_rotated(3,3)^2)));
rglobal = rad2deg(atan(T_rotated(3,2)/T_rotated(3,3)));
end

function dh = DHConvention(a,alpha,d,theta)
ca = cosd(alpha);
sa = sind(alpha);

c0 = cosd(theta);
s0 = sind(theta);

dh = [c0 -s0*ca s0*sa a*c0; s0 c0*ca -c0*sa a*s0; 0 sa ca d; 0 0 0 1];
end
