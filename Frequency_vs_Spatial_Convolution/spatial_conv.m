function output_img = spatial_conv(input_img, conv_kernel)
% input_img: type double
% conv_kernel: type double
% output_img: type double, size same as input_img
%% Write your function here
[RI,CI]=size(input_img);
[RK,CK]=size(conv_kernel);

R_new=RI+2*RK-2;
C_new=CI+2*CK-2;

v_pad=RK-1;
h_pad=CK-1;

padded_input_img=padarray(input_img,[v_pad h_pad],'circular');

output=conv2(padded_input_img,conv_kernel,'same');

%To show 'an input_image sized' output:
output_img=output(v_pad:R_new-v_pad-1,h_pad:C_new-h_pad-1);

end
