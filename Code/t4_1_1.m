clear
clc
close all
s = tf('s');
G = 3*(-s+1)/((5*s+1)*(10*s+1));
%% Lead-lag controller
wc = 0.4;
% [~,pm,~,~] = margin(G);
% deg = pm - 30;
beta = 0.545;
Td = 1/(wc*sqrt(beta));
K = sqrt(1+beta^2*Td^2*wc^2)*sqrt(1+25*wc^2)*sqrt(1+100*wc^2)/(3*sqrt(1+wc^2*Td^2)*sqrt(1+wc^2));
gamma = 0.001;
Ti = 10/wc;
F = K*(Td*s+1)/(beta*Td*s+1)*(Ti*s+1)/(Ti*s+gamma);
%% plot
figure(1)
margin(G)
hold on
margin(G*F)
legend('without lead-lag controller','with lead-lag controller')
hold off

figure(2)
stepplot(feedback(G,1))
stepinfo(feedback(G,1))
hold on
stepplot(feedback(G*F,1))
stepinfo(feedback(G*F,1))
legend('without lead-lag controller','with lead-lag controller')
%% bandwidth and resonnance peak
G_close = feedback(G*F,1)
fb = bandwidth(G_close)
[gpeak,fpeak] = getPeakGain(G_close);
gpeak_dB = mag2db(gpeak)