clc;
clear;
close all;
cd 'E:\Computer Vision\19gray\decode';
img = imread('scaledDisparityMap.png');
dismap = imread('disparityMap.png');

IMG = imcrop(img);

Z = double(IMG);
[X,Y] = meshgrid((1:size(IMG,2)),(1:size(IMG,1)));
W = double(Z~=0);

XX = sum(sum(W.*X.*X));
XY = sum(sum(W.*X.*Y));
XZ = sum(sum(W.*X.*Z));

YY = sum(sum(W.*Y.*Y));
YZ = sum(sum(W.*Y.*Z));

XS = sum(sum(W.*X));
YS = sum(sum(W.*Y));
ZS = sum(sum(W.*Z));
N  = sum(sum(W));

A = [XX XY XS 
     XY YY YS
     XS YS N];
B = [XZ; YZ; ZS];

P = A\B;

Zp = P(1)*X + P(2)*Y + P(3);
dz = W.*(Zp - Z);
error = sqrt(sum(sum(dz.*dz))/N);

mesh(Z);
hold on;
mesh(Zp);
