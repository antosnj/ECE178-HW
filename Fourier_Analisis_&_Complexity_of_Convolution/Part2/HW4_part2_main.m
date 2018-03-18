%% UCSB ECE178 (2017 Fall)
% HW4 MATLAB PART 2 - Convolution Analysis
%% Image credits
% nFF1x18.jpg: "Abstract Sketch Texture" by somadjinn on 
% rgbstock,com, used under RGBStock.com license
%% For students to complete
% brute_force_conv.m, seperated_conv.m, calc_MSE_2D.m
%% Clear up previous stuff
clc
clear 
close all
%% Load the input image
input_img = imread('../test_img.png');
%% Sub-part 1: Investigating benefit of separable kernel for convolution
fprintf('Part-2 \n');
kernel.matrix = [1,-2,1,0,-1]'*[1,3,-1,2,1]; % Large (5 by 5) Seperable Kernel
kernel.column = [1,-2,1,0,-1];
kernel.row = [1,3,-1,2,1];
[conv_res_1, time_1] = brute_force_conv(input_img, kernel);
[conv_res_2, time_2] = separated_conv(input_img, kernel);
% Time Analysis
fprintf('The convolution by brute force took %2.3f seconds \n',time_1);
fprintf('The convolution after separating the kernel took %2.3f seconds \n',time_2);
% MSE Analysis
MSE_1 = calc_MSE_2D(conv_res_1, conv_res_2);
fprintf('The MSE between the 2 convolved results is %8.3f \n',MSE_1);
fprintf('Paused...Press any key to continue to next sub-part \n');

figure,subplot(2,2,[1 2]),imshow(input_img),axis off;
subplot(2,2,3),imshow(uint8(conv_res_1)),axis off;
subplot(2,2,4),imshow(uint8(conv_res_2)),axis off;