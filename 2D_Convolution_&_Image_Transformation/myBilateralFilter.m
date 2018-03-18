function outImage = myBilateralFilter(A,w,sigma_s,sigma_r)
% A        : noisy input image (type: double)
% w        : window size for bilateral filter
% sigma_s  : spatial standard deviation for bilateral filter
% sigma_r  : range standar deviation for bilateral filter
% outImage : bilateral filtered output image (type: double)

%% implement bilateral filter here
[R,C]=size(A);

%First, creates a Gaussian filter that will later be used in the
%bilateral:
%Implements kernels X and Y using Matlab function 'meshgrid':
[X,Y]=meshgrid(-w:w,-w:w);
constant1=(2*pi*(sigma_s^2));

%Gaussian filter formula:
G_filter=exp(-(X.^2+Y.^2)./(2*(sigma_s^2)))/constant1;

%Defines new matrix for 'outImage':
outImage=zeros(R,C);

for i=1:R
    for j=1:C
      %Defines subimage of 'A' dimensions:      
      min_R=max(i-w,1);
      max_R=min(i+w,R);
      min_C=max(j-w,1);
      max_C=min(j+w,C);
      I=A(min_R:max_R,min_C:max_C); %Creates such subimage:

      %Bilateral filter formula:
      constant2=(2*sigma_r^2);
      H=exp(-(I-A(i,j)).^2/constant2);
      bilateral=H.*G_filter((min_R:max_R)-i+w+1,(min_C:max_C)-j+w+1);
      
      %Assigns to 'outImage' each value after convolution of A and the
      %new filter and normalize:
      aux1=sum(bilateral(:).*I(:));
      outImage(i,j)=aux1/sum(bilateral(:));

    end
end
        