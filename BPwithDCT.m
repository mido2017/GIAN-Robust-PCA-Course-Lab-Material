clc;
clear all;
close all;

load('103m.mat');
n = 256;
xorg = val(1,1:n)';

S = 40;            
m = ceil(n*S/100); % Sampling ratio

D = dctmtx(n);     % Discrete Cosine Transform 

A = randn(m,n);
y = A*xorg;

%% Solve using cvx
% for i = 1:maxIter
cvx_begin
variable xrec(n,1)
minimize (norm(D*xrec,1))
subject to
   y==A*xrec;
cvx_end
% end

%% Plot
plot(xorg)
hold on;
plot(xrec,'--r')