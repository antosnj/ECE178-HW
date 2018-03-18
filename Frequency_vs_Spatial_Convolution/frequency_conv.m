function output_img = frequency_conv(input_img, conv_kernel)
% input_img: type double
% conv_kernel: type double
% output_img: type double, size same as input_img
%% Write your function here
[RI,CI]=size(input_img);
[RK,CK]=size(conv_kernel);
input_img_F=fft2(input_img);

%Makes the kernel 'bigger' with zeros:
kernel2=zeros(RI,CI);

for k1=1:RK
    for k2=1:CK
        kernel2(k1,k2)=conv_kernel(k1,k2);
    end
end

l1=(RI-floor(RK/2)+1);
l2=(CI-floor(CK/2)+1);

kernel3=circshift(kernel2,[l1 l2]);

kernel_freq=fft2(kernel3);

convolved_freq=input_img_F.*kernel_freq;

%Inverse transform of previous result will be the output:
output_img=ifft2(convolved_freq);

end