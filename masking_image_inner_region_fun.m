
function [I_masked,BW]=masking_image_inner_region_fun(Im,NumPoints,value_background)


%Im=imread('BEF_a.tif');

I=double(Im);

figure(1);
imagesc(I);
colormap(gray);
axis('image');
title('Image');


[xc,yc]=ginput(NumPoints);
c=round(xc);
r=round(yc);

BW = roipoly(I,c,r);
BW=double(BW);

I_masked=BW.*value_background+I.*(ones(size(BW))-BW);

figure(2);
imagesc(I_masked);
axis image;
colormap(gray);
title('Masked Image');
















