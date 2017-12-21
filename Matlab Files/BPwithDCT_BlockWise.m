clc;
clear all;
close all;

load('103m.mat');
BlkLen = 256;
noOfBlk = 10;
n = BlkLen*noOfBlk;
S = 60;
m = ceil(BlkLen*S/100);
xorg = val(1,1:n)';
D = dctmtx(BlkLen);
z = dct(xorg);
plot(z);
% plot(xorg)
A = randn(m,BlkLen);

xrec = zeros(n,1);
for i = 1:noOfBlk
    xi = xorg(BlkLen*(i-1)+1:BlkLen*i);
    y = A*xi;

    %% Solve using cvx
    % for i = 1:maxIter
    cvx_begin
    variable xirec(BlkLen,1)
    minimize (norm(D*xirec,1))
    subject to
    y == A*xirec;
    cvx_end
    xrec(BlkLen*(i-1)+1:BlkLen*i) = xirec';
    % end
end

%% Plot
plot(xorg)
hold on;
plot(xrec,'--r')