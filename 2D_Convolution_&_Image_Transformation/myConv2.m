function output_img = myConv2(input_image, myfilter, padding_method)
% input_image    : noisy input image (type: double)
% myfilter       : filter kernel to be used for convolution (type: double)
% padding_method : string that specifies the type of padding method to be used
% output_img     : output image (type: double)

%% implement your 2D convolution here
[RI,CI]=size(input_image);
[RK,CK]=size(myfilter);

R_new=RI+2*RK-2;
C_new=CI+2*CK-2;

padded_input_image=zeros(R_new,C_new,'uint8'); %This is the "BIG IMAGE" ( I will call it like that later on the program ).

%% First, perform appropriate padding on the input_image to get padded_input_image
if strcmp(padding_method,'repeating')
    %REPEATING: Takes subimages of initial image and put them
    %on the big image, which initially was all zeros (value 255/black).   
    
    %Initial image:
        for k1=1:RI
          for k2=1:CI
              padded_input_image(k1+RK-1,k2+CK-1)=input_image(k1,k2);
          end
        end
        
    %Horizontal subimages:
        for k1=1:RI
            for k2=1:CK-1
                padded_input_image(k1+RK-1,k2)=input_image(k1,k2+CI-CK); %Left
                padded_input_image(k1+RK-1,k2+CK+CI-1)=input_image(k1,k2); %Right
            end
        end
    
    %Vertical subimages:
        for k1=1:RK-1
            for k2=1:CI
                padded_input_image(k1,k2+CK-1)=input_image(k1+RI-RK,k2); %Upper    
                padded_input_image(k1+RK+RI-1,k2+CK-1)=input_image(k1,k2); %Lower
            end
        end
    
    %Corners:
        for k1=1:RK-1
            for k2=1:CK-1
                padded_input_image(k1,k2)=input_image(k1+RI-RK,k2+CI-CK); %Top left
                padded_input_image(k1,k2+CK+CI-1)=input_image(k1+RI-RK+1,k2); %Top right
                padded_input_image(k1+RI+RK-1,k2)=input_image(k1,k2+CI-CK); %Bottom left
                padded_input_image(k1+RI+RK-1,k2+CK+CI-1)=input_image(k1,k2); %Bottom right       
            end
        end
    
elseif strcmp(padding_method,'mirroring')
    %MIRRORING: Takes subimages of initial image, FLIP them, and put them
    %on the big image, which initially was all zeros (black).
    %Initial image:
        for k1=1:RI
          for k2=1:CI
              padded_input_image(k1+RK-1,k2+CK-1)=input_image(k1,k2);
          end
        end

    %Horizontal subimages:
        for k1=1:RI
            for k2=1:CK-1
                padded_input_image(k1+RK-1,k2)=input_image(k1,CK-k2); %Left
                padded_input_image(k1+RK-1,k2+CK+CI-1)=input_image(k1,CI-k2); %Right
            end
        end
 
    %Vertical subimages:
        for k1=1:RK-1
            for k2=1:CI
                padded_input_image(k1,k2+CK-1)=input_image(RK-k1,k2); %Upper    
                padded_input_image(k1+RK+RI-1,k2+CK-1)=input_image(RI-k1,k2); %Lower
            end
        end    
    
    %Corners
        for k1=1:RK-1
            for k2=1:CK-1
                padded_input_image(k1,k2)=input_image(RK-k1,CK-k2); %Top left
                padded_input_image(k1,k2+CK+CI-1)=input_image(RK-k1,CI-k2); %Top right
                padded_input_image(k1+RI+RK-1,k2)=input_image(RI-k1,CK-k2); %Bottom left
                padded_input_image(k1+RI+RK-1,k2+CK+CI-1)=input_image(RI-k1,CI-k2); %Bottom right       
            end
        end
    
else 
    %ZERO PADDING:
    %Initial image:
    for k1=1:RI
       for k2=1:CI
          padded_input_image(k1+RK-1,k2+CK-1)=input_image(k1,k2);
       end
    end
end

%% perform convolution operation using the padded_input_image and myfilter to get the output_img
output_img=padded_input_image;
%First, flip the filter:
new_filter=fliplr(flipud(myfilter));
 
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
                     sum=sum+new_filter(k,l)*sub_matrix(k,l);
                 end 
             end
             output_img(i,j)=sum;
        end
    end
    
end
          
