clear all;
A2=load('projet_coupledA2.txt');
B1=load('projet_coupledB1.txt');
finA2=load('finA2.txt');
finB1=load('finB1.txt');
Cobs1=load('CO2_obs_2020.txt');

App21=load('interpol_App21.txt');
App22=load('interpol_App22.txt');

AppCO2A2=App21(:,2);
AppCO2B1=App21(:,3);

AppTA2=App22(:,2);
AppTB1=App22(:,3);

Cobs=Cobs1(:,2);

time=A2(:,1); 
Matm_A2=A2(:,2); 
Faso_A2=A2(:,3); 
Fatb_A2=A2(:,4);
deltaT_A2=A2(:,5);
F_in_A2=finA2(:,2);

Matm_B1=B1(:,2); 
Faso_B1=B1(:,3); 
Fatb_B1=B1(:,4);
deltaT_B1=B1(:,5);
F_in_B1=finB1(:,2);

subplot(2,2,1);
plot(time, Matm_A2/2.12)
hold on 
plot(time,Matm_B1/2.12)
legend('A2', 'B1','Location','northwest')
title('Evolution of atmospheric CO2 concentration');
ylabel('Concentration in CO2 (ppm)')
xlabel('Time')
xline(2022,'r--','Today','LabelHorizontalAlignment','left')


subplot(2,2,2);
plot(time, Fatb_A2,'r')
hold on 
plot(time, Faso_A2,'r--')
hold on 
plot(time,Fatb_B1,'b')
hold on
plot(time,Faso_B1,'b--')
legend('A2 - Atm/TB','A2 - Atm/oce', 'B1 - Atm/TB','B1 - Atm/oce','Location','northwest')
title('Evolution of atmospheric-terrestrial bioshere and atmospheric-ocean flux of CO2');
ylabel('CO2 (GT/yr)')
xlabel('Time')
xline(2022,'r--','Today','LabelHorizontalAlignment','left')

subplot(2,2,3);
plot(time, deltaT_A2)
hold on 
plot(time,deltaT_B1)
legend('A2', 'B1','Location','northwest')
title('Temperature evolution in atmosphere');
ylabel('Degree (°C)')
xlabel('Time')
xline(2022,'r--','Today','LabelHorizontalAlignment','left')

subplot(2,2,4);
plot(time, F_in_A2)
hold on 
plot(time,F_in_B1)
legend('A2', 'B1','Location','northwest')
title('Evolution of anthropogenic flux of CO2');
ylabel('CO2 (GT/yr)')
xlabel('Time')
xline(2022,'r--','Today','LabelHorizontalAlignment','left')
%%
figure; 
plot(time,AppCO2A2);
hold on 
plot(time,AppCO2B1);
hold on 
plot(time, Matm_A2/2.12);
hold on 
plot(time, Matm_B1/2.12);
legend('AppA2','AppB1','A2','B1','Location','northwest');

figure; 
plot(time,AppTA2);
hold on 
plot(time,AppTB1);
hold on 
plot(time, deltaT_A2);
hold on 
plot(time, deltaT_B1);
legend('AppA2','AppB1','A2','B1','Location','northwest');

