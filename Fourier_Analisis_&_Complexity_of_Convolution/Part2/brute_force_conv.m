function [conv_res_1, time_1] = brute_force_conv(input_img, kernel)
% Brute force convolution
tic;

[RI,CI]=size(input_img);
[RK,CK]=size(kernel.matrix);

R_new=RI+2*RK-2;
C_new=CI+2*CK-2;

padded_input_image=zeros(R_new,C_new,'uint8');

%ZERO PADDING:
%Initial image:
    for i=1:RI
        for j=1:CI
            padded_input_image(i+RK-1,j+CK-1)=input_img(i,j);
        end
    end


output_img=padded_input_image;

%%%%%%%%%% Brute force convolution %%%%%%%%%%%%
output_img=padded_input_image;
%First, flip the filter:
new_filter=fliplr(flipud(kernel.matrix));
 
length_R=(RK-1)/2;
length_C=(CK-1)/2;
 
%Takes submatrices (centered on each target pixel) of the padded image, multiply each element by
%the corresponding element of the filter, add everything up and assign that
%value to the target pixel of the resulting 2D convolution matrix:
    for i=RK-1:R_new-(RK-1)
        for j=CK-1:C_new-(CK-1)
            sub_matrix=padded_input_image(i-length_R:i+length_R,j-length_C:j+length_C);
            sum=0;
             for k=1:RK
                 for l=1:CK
                     sum=sum+double(new_filter(k,l))*double(sub_matrix(k,l));
                 end 
             end
             output_img(i,j)=sum;
        end
    end

%To show the original image without padded borders effect:
conv_res_1=output_img((RK-1):(RK-1)+RI-1,(CK-1):(CK-1)+CI-1);

time_1=toc;

end