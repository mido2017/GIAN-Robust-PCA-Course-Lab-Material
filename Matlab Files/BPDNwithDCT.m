% Basis Pursuit DeNoising on ECG Signal 
clc;
clear all;
close all;

rng(1)
load('103m.mat');
n = 256;
xorg = val(1,1:n)';
xorg=(xorg-1024)/200;
 
D = dctmtx(n);

% std = 0.*mean(xorg);
y = xorg+0.1*randn(n,1);

%% Solve using cvx
% for i = 1:maxIter
lambda = 0.09; % Hyperparameter 
cvx_begin
variable xrec(n,1)
minimize (norm(y-xrec,2)+lambda*(norm(D*xrec,1)));
cvx_end
% end

%% SNR
calSNR(xorg,y,0)
calSNR(xorg,xrec,0)

%% Plot
plot(xorg)
hold on;
plot(y,'--r')