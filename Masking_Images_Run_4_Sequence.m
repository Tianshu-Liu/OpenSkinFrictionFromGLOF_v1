
% read an image for template
imagefile=strcat('C:\Tianshu Liu\Tianshu_WMU\GLOF_Diagnostics\GLOF_Diagnostics_Programs_V1_square_junction\GLOF_images\001.jpg');
Im1 =imread(imagefile);

imshow(uint8(Im1));

% % select a region in the template image
xy=ginput(2);
x1=floor(min(xy(:,1)));
x2=floor(max(xy(:,1)));
y1=floor(min(xy(:,2)));
y2=floor(max(xy(:,2)));

X =imread(imagefile);
I_templat=X(y1:y2,x1:x2); 
    
figure(200);
imagesc(I_templat);
colormap('gray')
colorbar
axis image;


% mask the template image
NumPoints_outer=4;
NumPoints_inner=4;
value_background=5;
if NumPoints_outer~=0
    [I_masked_outer,BW_outer]=masking_image_outer_region_fun(I_templat,NumPoints_outer,value_background);
elseif NumPoints_outer==0
    I_masked_outer=Im1;
end

[I_masked,BW_inner]=masking_image_inner_region_fun(I_masked_outer,NumPoints_inner,value_background);


figure(300);
imagesc(I_masked);
colormap('gray')
colorbar
axis image;



skip=6;
minframe=1;    
maxframe=486;   

% mask sequence of images
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
    Im1=double(X(y1:y2,x1:x2)); 
    
    
    I_masked_outer=BW_outer.*Im1+value_background*(ones(size(BW_outer))-BW_outer);
    I1=BW_inner.*value_background+I_masked_outer.*(ones(size(BW_inner))-BW_inner);
    
    
    Name_output=strcat('square_junction_masked_',num2str(k));
    IMWRITE(uint8(I1),strcat(Name_output,'.jpg'));
        
    figure(400);
    imagesc(I1);
    colormap('gray')
    colorbar
    axis image;
    
    k=k+1;
    i
end

% save BW_outer.dat BW_outer -ascii;
% save BW_inner.dat BW_inner -ascii;







