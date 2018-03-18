function [PR] = myRadon(img, theta_all)
% img: input image (type double)
% theta_all: list of angles in degrees (length=K)
% PR: radon transform (type double)(size: N x K) 
%% your implementation here
[R,C]=size(img);
diagonal=ceil(sqrt(R^2+C^2));

%Defines size of the output radon transform:
PR=zeros(diagonal,length(theta_all));

for k=1:length(theta_all)
    %Rotates image:
    rotated_img=imrotate(img,-theta_all(k));
    C_rot=size(rotated_img,2);
    
    %Defines padding length, so that we do not lose information after rotating:
    pad=floor((diagonal-C_rot)/2);

    %Performs Radon Transform: 
    sub_P=zeros(diagonal,1);    
        for j=1:C_rot
            sub_P(j+pad)=sub_P(j+pad)+sum(rotated_img(:,j));
        end
    PR(:,k)=sub_P;
end

end



