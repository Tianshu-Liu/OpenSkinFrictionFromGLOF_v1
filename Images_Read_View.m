
%Code to read appropriate frames from the multi-tif files from PCO-camera, 
%apply 2-D filter, find Temperature, and trace temperature in time for a given point 

clear all
close all

%imagefile=strcat('C:\Tianshu Liu\Tianshu_WMU\Global_Oil_Film\GLOF_Diagnostics\GLOF_Diagnostics_Programs_V1\Test 15 (0.0014 psi 13 deg 200cs)\capture0001.jpg');
imagefile=strcat('C:\Tianshu Liu\Tianshu_WMU\GLOF_Diagnostics\GLOF_Diagnostics_Programs_V1_square_junction\GLOF_images\001.jpg');
Im1 =imread(imagefile);
Im1 =imread(imagefile);

imshow(uint8(Im1));
% % select a region for optical flow calculation
xy=ginput(2);
x1=floor(min(xy(:,1)));
x2=floor(max(xy(:,1)));
y1=floor(min(xy(:,2)));
y2=floor(max(xy(:,2)));


skip=6;
minframe=1;    %Tunnel start occurs at (around) this frame number
maxframe=486;    %Tunnel un-start occurs at (around) this frame number


% Flow-on case with heating
k=1;
for i=minframe:skip:maxframe
    if i<10
        imagefile=strcat('C:\Tianshu Liu\Tianshu_WMU\GLOF_Diagnostics\GLOF_Diagnostics_Programs_V1_square_junction\GLOF_images\00',num2str(i),'.jpg');
    elseif (i>=10) && (i<100)
        imagefile=strcat('C:\Tianshu Liu\Tianshu_WMU\GLOF_Diagnostics\GLOF_Diagnostics_Programs_V1_square_junction\GLOF_images\0',num2str(i),'.jpg');
    elseif (i>=100) && (i<1000)
        imagefile=strcat('C:\Tianshu Liu\Tianshu_WMU\GLOF_Diagnostics\GLOF_Diagnostics_Programs_V1_square_junction\GLOF_images\',num2str(i),'.jpg');
    else
        imagefile=strcat('C:\Tianshu Liu\Tianshu_WMU\GLOF_Diagnostics\GLOF_Diagnostics_Programs_V1_square_junction\GLOF_images\',num2str(i),'.jpg');   
    end

    
    X =imread(imagefile);
    Im2=X(y1:y2,x1:x2); 
    
    figure(200);
    imagesc(Im2);
    colormap('gray')
    colorbar
    axis image;
    k=k+1;
    i
end


