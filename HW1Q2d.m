clc
clear
close all

rpm=[1000 1500 2000 2500 3000 3500 4000 4500 4700];
torq=1.35582*[299 489 516 513 503 478 441 391 361]; %torq in Nm
w=(2*pi/60)*rpm; %engine speed in rad/s
GR=[5.5 3.52 2.2 1.72 1.32 1 0.826 0.64]; %Gear ratio
FDR=3.077;
WheelR=0.5334; %tire radius in meters

%% Plot gear curves
figure('Color','w');
for k=1:8
    V=w*(FDR*GR(k))^-1*WheelR;
    Ft=torq*(FDR*GR(k)/WheelR);
    plot(V*3.6,Ft/1000,'-'); 
    hold on

end
grid on
xlabel('Vehicle speed [Km/h]');
ylabel('Traction force [kN]');
title('Traction curve for each gear');

%% add other lines
V_p=40:0.1:500;
Pmax=250.455; % max power in kW
F_p=Pmax*V_p.^-1; % kN
plot(V_p,3.6*F_p,'.k'); % Maximum power curve
MSV=0:0.1:100;
MSF=ones(length(MSV))*22.791; % miu*m*g
plot(MSV,MSF,'-.r'); % traction limit line 

%% Road load

Cd=0.32;
A=2.83; %m^2
rho=1.21;
fr=0.01;
m=2214.9; %mass in kg
g=9.8;
rg=0.08;
theta=atan(rg);
Frl=Cd*A*rho*(V_p/3.6).^2*0.5+fr*m*g*cos(theta)...
    +m*g*sin(theta);
plot(V_p,Frl/1000,'-.r'); %road load curve

%% Legend
legend('1st','2nd','3rd','4th','5th','6th','7th','8th','max Power','Traction lim','Road Load');


