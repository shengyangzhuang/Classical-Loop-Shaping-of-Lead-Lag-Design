clear; 
close all; 
clc;
s = tf('s');
G = 20/((s+1)*((s/20)^2+s/20+1));
Gd = 10/(s+1);
[~,~,~,wc] = margin(Gd);
G1 =wc/s;
%% Improper Controller
Fy_improper = G1*G^-1;
% Loop Gain
L_improper = G*Fy_improper;
% close loop transfer function of d to y
Gdcl_improper = Gd / (1+L_improper);
%% Proper Controller 
% Add 3 poles at least in order to make the Fy proper and ensure that the Bode plot and step plot of closed loop tf remains the same
%% Observation: Take three poles at least at 50*Wc
p1 = 100*wc;
p2 = 100*wc;
p3 = 100*wc;
Fy_proper = Fy_improper * tf(1,[1/p1,1])* tf(1,[1/p2,1])* tf(1,[1/p3,1]);
% Loop Gain
L_proper = G*Fy_proper;
% close loop transfer function of d to y
Gdcl_proper = Gd / (1+L_proper);
%% Plotting
% make sure L is approximately equal to G1
figure(1)
margin(L_improper)
hold on 
margin(L_proper)
hold off
legend('L\_improper','L\_proper')
% make sure bode plot remains the same when ?
figure(2)
margin(Gdcl_improper)
hold on 
margin(Gdcl_proper)
hold off
legend('Gdcl\_improper','Gdcl\_proper')
% make sure step plot remains the same
figure(3)
stepplot(Gdcl_improper)
hold on 
stepplot(Gdcl_proper)
hold off
legend('Gdcl\_improper','Gdcl\_proper')
grid on