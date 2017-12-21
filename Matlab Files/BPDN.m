clc;
clear all;
close all;

% 
n =256; m =100; k =10;
xorg = zeros(n,1);
idx = randperm(n,k);
xorg(idx) = randn(k,1);

A = randn(m,n);
y = A*xorg+0.5*randn(m,1); % Random Gaussian noise with variance 0.5 and mean 0

%% Solve using cvx
rho = 0.5*sqrt(n+2*sqrt(2*n))*sqrt(0.5); % delta hyperparamter 
% for i = 1:maxIter
cvx_begin
variable x(n,1)
minimize (norm(x,1))
subject to
   norm(y-A*x,2)<=rho;
cvx_end
% end

%% Plot
stem(xorg)
hold on;
stem(x,'--r')