%% This is a subrutine for extraction of a snapshot solution of
%% skin-friction feild from a pair of GLOF images

function [tor_x,tor_y]=snapshot_solution_fun(I1,I2,lambda_1,lambda_2,scale_im,size_filter)

I1_original=I1;
I2_original=I2;

% pre-processing for reducing local change of illumination level and random noise,
% and downsampling images if displacements are large

size_average=0; % pixels, To bypass the correction for illumination change, set size_average = 0

[I1,I2] = pre_processing_a(I1,I2,scale_im,size_filter);

I_region1=I1;
I_region2=I2;




%% optical flow calculation
%lambda_1:  Lagrange multiplier in the Horn-Schunck estimator
%lambda_2:  Lagrange multiplier in the Liu-Shen estimator

[ux0,uy0,vor,ux_horn,uy_horn,error1]=OpticalFlowPhysics_fun(I_region1,I_region2,lambda_1,lambda_2);
% ux is the velocity (pixels/unit time) in the image x-coordinate (from the left-up corner to right)
% uy is the velocity (pixels/unit time) in the image y-coordinate (from the left-up corner to bottom)


ux_corr=ux0;
uy_corr=uy0;

%% cobert to the skin-friction vector by normilization
g=(I1+I2)/2;
tor_x=ux_corr./g;
tor_y=uy_corr./g;














