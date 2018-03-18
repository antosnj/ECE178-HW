function [conv_res_2, time_2] = separated_conv(input_img, kernel)
%Do convolution with the image and the separated kernel

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

output_img_1=double(padded_input_image);
output_img=padded_input_image;

%%%%%%%%%%%% Convolution with separated kernel: %%%%%%%%%%%%%%%

kernel_R=kernel.row;
kernel_C=kernel.column';

kernel_center_R=round(RK/2);
kernel_center_C=round(CK/2);

%Kernel row:
for i=1:((R_new)-(CK-1))
    for j=1:((C_new)-(RK-1))
        sum=0;
        for k=1:CK
            aux=double(padded_input_image(i,j+k-1))*double(kernel_R(1,k));
            sum=sum+aux;
        end
        output_img_1(i-1+kernel_center_R,j-1+kernel_center_C)=sum;
    end
end

%Kernel column:
for i=1:((R_new)-(CK-1))
    for j=1:((C_new)-(RK-1))
        sum=0;
        for k=1:RK
            aux=double(output_img_1(i+k-1,j))*double(kernel_C(k,1));
            sum=sum+aux;
        end
        output_img(i-1+kernel_center_R,j-1+kernel_center_C)=sum;
    end
end

%To show the original image without padded borders effect:
conv_res_2=output_img((RK-1):(RK-1)+RI-1,(CK-1):(CK-1)+CI-1);

time_2=toc;

end