close all;
clear all;

tor_x=load('tor_x_square.dat');
tor_y=load('tor_y_square.dat');
I1=load('sample_image_square.dat');

tor_mag=(tor_x.^2+tor_y.^2).^0.5;

% plot the normalized temperature image
figure(1);
I_max=max(max(I1));
I1=I1/I_max;
s=[0 1.2];
imagesc(I1,s);
%imagesc(I1);
axis image;
xlabel('x (pixels)');
ylabel('y (pixels)');
colormap('pink')
colorbar;


% plot skin-friction vectors


figure(2);
gx=40; offset=1;
[Vx Vy] = vis_flow (tor_x, tor_y, gx, offset, 3, 'm');
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
title('Skin Friction Vectors');


% plot the normalized skin-friction megnitude field
figure(3);
tor_max=max(max(tor_mag));
tor_mag=tor_mag/tor_max;
r=[0.1 1];
imagesc(tor_mag,r);
colormap('pink');
colorbar;
axis image;
xlabel('x (pixels)');
ylabel('y (pixels)');
title('Skin Friction Magnitude Field');

% plot skin-friction lines
figure(4);
[m,n]=size(tor_x);
[x,y]=meshgrid(1:n,1:m);
x30=(x-0);
y30=(y-0);
dn=5;
dm=5;
[sx,sy]=meshgrid(1:dn:n,1:dm:m);
h=streamslice(x30, y30, tor_x, tor_y, 20);
set(h, 'Color', 'red');
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
title('Skin Friction Lines');






