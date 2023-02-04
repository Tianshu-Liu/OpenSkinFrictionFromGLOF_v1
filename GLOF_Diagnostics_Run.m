%% This is the main program for extraction of relative skin-friction field
%% from global luminescent oil-film (GLOF) visualization image sequence of
%% the square junction flow
%% Copyrights by Tianshu Liu
%% Department of Mechanical and Aerospace Engineering,
%% Western Michigan University, Kalamazoo, MI, USA

close all;
clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Set the Parameters for Optical Flow Computation

%% Set the lagrange multipleirs in optical computation 

lambda_1=20; % Horn-Schunck estimator for initial estimation
lambda_2=2000; % Liu-Shen estimator for refined estimation


%% For Image Pre-Processing
%% scale_im is a scale factor for down-sizing of images
scale_im=0.5; 

%% Gausian filter size for removing random noise in images
size_filter=1; % in pixels

%% masking images (index_masking = 1) otherwise there is no masking (index_masking = 0)
index_masking=1;

%% Selete a region for processing (index_region = 1) otherwise processing for the
%% whole image (index_region = 0)
index_region=1;


%% compute snapshot solutions from sequence of image pairs and averaging the snapshot solutions
step=1;         % step between two sequent images
minframe=3;     % starting image 
maxframe=80;    % ending image

Im1=imread('square_junction_masked_1.jpg');
[Im1,Im1] = pre_processing_a(Im1,Im1,scale_im,size_filter);

tor_x=zeros(size(Im1));
tor_y=zeros(size(Im1));

k=1;
for i=minframe:maxframe
    if i<1000
        imagefile=strcat('square_junction_masked_',num2str(i),'.jpg');
    elseif (i>=10) && (i<100)
        imagefile=strcat('square_junction_masked_',num2str(i),'.jpg');
    elseif (i>=100) && (i<1000)
        imagefile=strcat('square_junction_masked_',num2str(i),'.jpg');
    else
        imagefile=strcat('square_junction_masked_',num2str(i),'.jpg');   
    end
    
    Im1 =imread(imagefile);
       
    if i<1000
        imagefile=strcat('square_junction_masked_',num2str(i+step),'.jpg');
    elseif (i>=10) && (i<100)
        imagefile=strcat('square_junction_masked_',num2str(i+step),'.jpg');
    elseif (i>=100) && (i<1000)
        imagefile=strcat('square_junction_masked_',num2str(i+step),'.jpg');
    else
        imagefile=strcat('square_junction_masked_',num2str(i+step),'.jpg');   
    end
    
    Im2 =imread(imagefile); 
    
    Im1=double(Im1);
    Im2=double(Im2);
    
    [tor_x_add,tor_y_add]=snapshot_solution_fun(Im1,Im2,lambda_1,lambda_2,scale_im,size_filter);
    
    tor_x=tor_x+tor_x_add;
    tor_y=tor_y+tor_y_add; 
    
    k=k+1;

end


tor_x=tor_x/(k-1);
tor_y=tor_y/(k-1);


tor_mag=(tor_x.^2+tor_y.^2).^0.5;


%% masking the skin-friction field
[Im1,Im2] = pre_processing_a(Im1,Im2,scale_im,size_filter);

if (index_masking == 1)
    BW=load('BW_square.dat');
    [BW1,BW1] = pre_processing_a(BW,BW,scale_im,size_filter);

    value_background=0;
    tor_x=BW1.*value_background+tor_x.*(ones(size(BW1))-BW1);
    tor_y=BW1.*value_background+tor_y.*(ones(size(BW1))-BW1);
    tor_mag=BW1.*value_background+tor_mag.*(ones(size(BW1))-BW1);
    Im1=BW1.*value_background+Im1.*(ones(size(BW1))-BW1);
    Im2=BW1.*value_background+Im2.*(ones(size(BW1))-BW1);
elseif (index_masking == 0)
    Im1=Im1;
    Im2=Im2;
    tor_x=tor_x;
    tor_y=tor_y;
end

%% Selete a region of interest for dognostics

[m,n]=size(Im1);
if (index_region == 1)    
    % selecting a region by setting the coordinates
    x1=10;
    x2=n-10;
    y1=1;
    y2=m;
    
    tor_x=tor_x(y1:y2,x1:x2);
    tor_y=tor_y(y1:y2,x1:x2);
    tor_mag=tor_mag(y1:y2,x1:x2);
    Im1=Im1(y1:y2,x1:x2);    
    Im2=Im2(y1:y2,x1:x2);    
elseif (index_region == 0)
    tor_x=tor_x;
    tor_y=tor_y;
    tor_mag=tor_mag;
    Im1=Im1;
    Im2=Im2;
end

I1=Im1;
I2=Im2;

Plots;

% dlmwrite('tor_x_square.dat', tor_x);
% dlmwrite('tor_y_square.dat', tor_y);
% dlmwrite('sample_image_square.dat', I1);














