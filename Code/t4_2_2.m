clear
close all
clc
s = tf('s');
G = 20/((s+1)*((s/20)^2+s/20+1));
Gd = 10/(s+1);
%[~,~,~,wc] = margin(Gd);
wc=10;
G1 =wc/s;
%% Improper Controller2
p1 = 80*wc;
p2 = 80*wc;
p3 = 80*wc;
Fy_improper2 = G1*G^-1* tf(1,[1/p1,1])* tf(1,[1/p2,1])* tf(1,[1/p3,1]);
% Loop Gain
L_improper2 = G*Fy_improper2;
% close loop transfer function of d to y
Gdcl_improper2 = Gd / (1+L_improper2);
%% further design on Fy
wi=10*wc; %debug
Gpi=(s+wi)/s;
Fy_proper=Gpi*G^-1*Gd* tf(1,[1/p1,1])* tf(1,[1/p2,1])* tf(1,[1/p3,1]);
%% plot
L_proper=G*Fy_proper;
Gdcl_proper=(1+L_proper)^-1*Gd;
stepplot(Gdcl_improper2,6)
hold on
stepplot(Gdcl_proper,6)
legend('Gdcl\_improper2','Gdcl\_proper')
grid on