clc;
clear all;
close all;

% 
n =100; m =50; k =10;
xorg = zeros(n,1);
idx = randperm(n,k);
xorg(idx) = randn(k,1);

A = randn(m,n);
y = A*xorg;

%% Solve using cvx
% for i = 1:maxIter
cvx_begin
variable x(n,1)
minimize (norm(x,1))
subject to
   y==A*x;
cvx_end
% end

%% Plot
stem(xorg)
hold on;
stem(x,'--r')