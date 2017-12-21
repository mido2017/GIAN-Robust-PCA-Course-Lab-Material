clc;
clear all;
close all;

rng(1)
load('103m.mat');
n = 256;
xorg = val(1,1:n)';
xorg=(xorg-1024)/200;
 
D = dctmtx(n);

k =10;
im = zeros(n,1);
idx = randperm(n,k);
im(idx) = 0.2*randn(k,1);

xnoisy = xorg+im;

% %% Plot
% plot(xorg)
% hold on;
% plot(xnoisy,'--r')

%% Solve using cvx
% for i = 1:maxIter
lambda = 1;
cvx_begin
variable xrec(n,1)
minimize (norm(xnoisy-xrec,1)+lambda*(norm(D*xrec,1)));
cvx_end
% end

%% SNR
calSNR(xorg,xnoisy,0)
calSNR(xorg,xrec,0)

%% Plot
plot(xorg)
hold on;
plot(xnoisy,'--r')
hold on;
plot(xrec,'k')