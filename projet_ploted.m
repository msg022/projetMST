clear all;
A2=load('projet_coupledA2.txt');
B1=load('projet_coupledB1.txt');
finA2=load('finA2.txt');
finB1=load('finB1.txt');
Cobs1=load('CO2_obs_2020.txt');

App21=load('interpol_App21.txt');
App22=load('interpol_App22.txt');

reserv_A2=load('reserv_A2_modif.txt');
reserv_B1=load('reserv_B1_modif.txt');

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

Mls_A2=reserv_A2(:,2);
Mtb_A2=reserv_A2(:,3);
Mso_A2=reserv_A2(:,4);
Mob_A2=reserv_A2(:,5);
Mdo_A2=reserv_A2(:,6);
Mat_A2=reserv_A2(:,7);

Mls_B1=reserv_B1(:,2);
Mtb_B1=reserv_B1(:,3);
Mso_B1=reserv_B1(:,4);
Mob_B1=reserv_B1(:,5);
Mdo_B1=reserv_B1(:,6);
Mat_B1=reserv_B1(:,7);



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
%%
figure; 
valeurs_Mat = [Mat_A2, Mat_B1];
valeurs_Mls = [Mls_A2, Mls_B1];
valeurs_Mtb = [Mtb_A2, Mtb_B1];
valeurs_Mso = [Mso_A2, Mso_B1];
valeurs_Mob = [Mob_A2, Mob_B1];
valeurs_Mdo = [Mdo_A2, Mdo_B1];

subplot(2,3,1)
bar(valeurs_Mat);
title(sprintf('Différence on CO2 concentration between \n A2 and B1 in atmosphere'))
ylabel('CO2 concentration (GT C)')
text(1:length(valeurs_Mat), valeurs_Mat, {'A2', 'B1'}, ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'cap');
subplot(2,3,2)
bar(valeurs_Mls);
title(sprintf('Différence on CO2 concentration between \n A2 and B1 in land soil'))
ylabel('CO2 concentration (GT C)')
text(1:length(valeurs_Mls), valeurs_Mls, {'A2', 'B1'}, ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'cap');
subplot(2,3,3)
bar(valeurs_Mtb);
title(sprintf('Différence on CO2 concentration between \n A2 and B1 in terrestrial biosphere'))
ylabel('CO2 concentration (GT C)')
text(1:length(valeurs_Mtb), valeurs_Mtb, {'A2', 'B1'}, ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'cap');
subplot(2,3,4)
bar(valeurs_Mso);
title(sprintf('Différence on CO2 concentration between \n A2 and B1 in surface ocean'))
ylabel('CO2 concentration (GT C)')
text(1:length(valeurs_Mso), valeurs_Mso, {'A2', 'B1'}, ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'cap');
subplot(2,3,5)
bar(valeurs_Mob);
title(sprintf('Différence on CO2 concentration between \n A2 and B1 in biosphere'))
ylabel('CO2 concentration (GT C)')
text(1:length(valeurs_Mob), valeurs_Mob, {'A2', 'B1'}, ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'cap');
subplot(2,3,6)
bar(valeurs_Mdo);
title(sprintf('Différence on CO2 concentration between \n A2 and B1 in deepocean'))
ylabel('CO2 concentration (GT C)')
text(1:length(valeurs_Mdo), valeurs_Mdo, {'A2', 'B1'}, ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'cap');

%%
data=load('outclim_A2-2100.txt');

Matm_uc=data(:,2);
deltaT_uc=data(:,3);
AF_uc=data(:,4);

display(AF_uc);
display(deltaT_uc);
display(Matm_uc);



















