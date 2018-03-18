function [MSE]=calc_MSE_2D(conv_res_1,conv_res_2)
% Calculate Mean Squared Error between the two input images
[R,C]=size(conv_res_1);

%Mean Squared Error:
MSE_1=(conv_res_1-conv_res_2).^2;

dimension=R*C;
MSE=sum(sum(MSE_1))/(dimension);

end