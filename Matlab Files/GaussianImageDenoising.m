clc;
clear all;
close all;

orgImg = im2double(imread('Lena512.bmp'));
orgImg = imresize(orgImg,[64,64]);
[m,n] = size(orgImg);
std = 0.1;
noisyImg = orgImg+std*randn(m,n);

%% Show noisy image
imshow(orgImg);
figure;
imshow(noisyImg);

D1= dctmtx(m);
D2 = dctmtx(n);

%% Solve using cvx
% for i = 1:maxIter
lambda = 0.1;
cvx_begin
variable recImg(m,n)
minimize norm(noisyImg-recImg,'fro')+lambda*norm(reshape(D1*recImg*D2',m,n),1);
cvx_end
% end

%% Plot
imshow(orgImg);
figure;
imshow(recImg)