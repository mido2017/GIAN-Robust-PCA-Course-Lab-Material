clc;
clear all;
close all;

% 
n =100; m =50; k =20;
xorg = zeros(n,1);
idx = randperm(n,k);
xorg(idx) = randn(k,1);

A = randn(m,n);
y = A*xorg;

%% Solve using cvx
p=0.3;
eps = 1e-3;
maxIter = 30;
W = diag((eps).^(p/2-1));
for i = 1:maxIter
    cvx_begin
    variable x(n,1)
    minimize (norm(W*x,1))
    subject to
    y==A*x;
    cvx_end
    W = diag((abs(x)+eps).^(p/2-1));
end

%% Plot
stem(xorg)
hold on;
stem(x,'--r')