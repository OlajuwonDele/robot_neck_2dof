clear variables
type rangeofmotion.txt
fileID = fopen('rangeofmotion.txt','r');
formatSpec = '%f %f';
sizeA = [3 Inf]
A = fscanf(fileID,formatSpec,sizeA)
parameters = A'

time = (parameters(:,1)+32457)/543.4083;
pitch = parameters(:,2);
roll = parameters(:,3) ;

for i = 1:1:size(time,1)
    if time(i) >= 80 
        rollp(i) = roll(i);
        timep(i) = time(i);
        pitchp(i) = pitch(i);
    end

end
sz = 40;
figure(1)
hold on
scatter(pitch,roll, sz,'MarkerEdgeColor',[0 .5 .5], 'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5)
grid on;
xlabel('\theta_p [\circ]'), ylabel('\theta_r [\circ]')
xlim tight ;
fontsize(gcf,scale=1.7)
ylim tight
title('Optimised Neck Mechanism Configuration Range of Motion')
hold off


figure(2)
hold on
plot(time,roll,'r-',time, pitch, 'b-', 'Linewidth', 1)
grid on;
xlim tight ;
fontsize(gcf,scale=1.7)
ylim tight
xlabel('time [s]'), ylabel('Angle [\circ]')
title('Optimised Neck Mechanism Configuration Range of Motion')
legend('Roll', 'Pitch')
hold off