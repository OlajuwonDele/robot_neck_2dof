clear variables


phase = 180;
phase2 = 120;
phase3 = 240;
dac_in = 4095;
dac_out = 4095;
x = 1:1:1000;
air_delay = 2;
min_number_in = 2900;
min_number_out = 0;

inlet1 = max(min_number_in,dac_in*sind((air_delay*x)));
exhaust1 = max(min_number_out,dac_out*sind((air_delay*x+phase)));


inlet2 = max(min_number_in,dac_in*sind((air_delay*x+phase2)));
exhaust2 = max(min_number_out,dac_out*sind((air_delay*x+phase+phase2)));


inlet3 = max(min_number_in,dac_in*sind((air_delay*x+phase3)));
exhaust3 = max(min_number_out,dac_out*sind((air_delay*x+phase+phase3)));

figure(10)
hold on
plot(x, inlet1, 'r', 'LineWidth',2)
plot(x, exhaust1, 'r--', 'LineWidth',2)

plot(x, inlet2, 'b', 'LineWidth',2)
plot(x, exhaust2, 'b--', 'LineWidth',2)
plot(x, inlet3, 'g', 'LineWidth',2)
plot(x, exhaust3, 'g--', 'LineWidth',2)
fontsize(gcf,scale=1.7)
legend('Inlet_1', 'Exhaust_1', 'Inlet_2', 'Exhaust_2', 'Inlet_3', 'Exhaust_3')
grid on;
xlabel('t [s]'), ylabel('Orifice DAC')
title('Pressure Valves System Swivel Motion')
hold off

