clear
close all
clc
s = tf('s');
G = 20/((s+1)*((s/20)^2+s/20+1));
Gd = 10/(s+1);
%[~,~,~,wc] = margin(Gd);
wc=10;
G1 =wc/s;
%% Improper Controller3
p1 = 80*wc;
p2 = 80*wc;
p3 = 80*wc;
wi=10*wc; %choose wc such that it has margin
Gpi=(s+wi)/s;
Fy_improper3 = Gpi*Gd*G^-1* tf(1,[1/p1,1])* tf(1,[1/p2,1])* tf(1,[1/p3,1]);
% Loop Gain
L_improper3 = G*Fy_improper3;
% close loop transfer function of d to y
Gdcl_improper3 = Gd / (1+L_improper3);
%% add lead action to Fy
% [~,~,~,wcy] = margin(L_improper3);
% [~,pm,~,~] = margin(L_improper3);
% deg = pm - 50;
% beta = 0.25;
% Td = 1/(wcy*sqrt(beta));
% K = sqrt(1+Td^2*beta^2*wcy^2)*20*wcy^2*(sqrt(1+(wcy/(100*wcy))^2))^3/(sqrt(1+Td^2*wcy^2)*wcy*sqrt(1+wcy^2)*wcy*sqrt(2)*sqrt((1-1/20*wcy^2)^2+(wcy/20)^2));
% F_lead = K*(Td*s+1)/(beta*Td*s+1);
 F_lead=0.06*(0.3*s+1)/(0.2*0.3*s+1);
%% design of Fr
tau= 0.1;
Fr = 1/(1+tau*s);
%% plot
figure(1)
Fy_proper = Fy_improper3*F_lead;
L_proper = G*Fy_proper;
S=1/(1+L_proper);
T = 1-S;
stepplot(Fy_proper*Fr*S)
legend('control signal for a reference step')
% hold on
% stepplot(Fy_proper*Gd*S)
% legend('u -> r','u -> d')
% hold off
grid on
% stepplot(Fy_proper*Fr*S-Fy_proper*Gd*S)
%% plot
figure(5)
bode(S)
hold on
bode(T)
legend('S','T')

%% Check the code
% step response of r->y
figure(2)
stepplot(Fr*T)
grid on
stepinfo(Fr*T)
legend('Reference step')
% step response of d->y
figure(3)
stepplot(S*Gd)
grid on
%step response of u
figure(4)
stepplot(Fy_proper*Fr*S-Fy_proper*Gd*S)
grid on
legend('control signal u')