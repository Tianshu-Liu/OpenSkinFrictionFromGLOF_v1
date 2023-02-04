
% mask a image by selecting a region

clear all
close all

% read image
I=imread('square_junction_masked_1.jpg');
% I=rgb2gray(I(:,:,1:3));
%I=double(I);

%I=load('IRR_delta_dlr_a.dat');

figure(1);
% s=[0.35 0.5];
% imagesc(I,s);
imagesc(I); 
colormap(pink);
axis image;
colorbar;


% select a region using a masking function
NumPoints=4;
value_background=0;
[I_masked,BW]=masking_image_inner_region_fun(I,NumPoints,value_background);

%Is=BW.*value_background+I.*(ones(size(BW))-BW);
Is=I_masked;

figure(3);
imagesc(Is);
colormap(gray);
axis image;


% dlmwrite('sample_square_masked1.dat',Is);
% dlmwrite('BW_square.dat',BW);


