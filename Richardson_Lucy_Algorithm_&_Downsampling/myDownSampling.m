function downsampled_img = myDownSampling(input_img, downsampling_rate, method)

%NO ANTI-ALIASING:
if strcmp(method,'No Filtering')  

  [R,C]=size(input_img); 
  
  %Compute the downsampling:
  s1=floor(R/downsampling_rate);
  s2=floor(C/downsampling_rate);
  
  downsampling_size=[s1,s2];
  downsampled_img_1=uint8(zeros(downsampling_size));
    
  for i=1:downsampling_size(1)
        for j=1:downsampling_size(2)
            downsampled_img_1(i,j)=input_img(i*downsampling_rate,j*downsampling_rate);
        end
  end
    
  downsampled_img=downsampled_img_1;

%BOX FILTER:
elseif strcmp(method,'Box filter')  
    
  %Firstly, create the box filter:
  box_filter=double(zeros(17,17));
  for i=1:17
      for j=1:17
            box_filter(i,j)=(1/(17)).^2;
      end
  end
    
  %Convolve the input image with the previously created box filter:
  [R,C]=size(input_img);
    
  filtered_img=conv2(double(input_img),box_filter,'same');
    
  %Compute the downsampling:
  downsampling_size=[floor(R/downsampling_rate),floor(C/downsampling_rate)];
  downsampled_img_1=uint8(zeros(downsampling_size));

  for i=1:downsampling_size(1)
      for j=1:downsampling_size(2)
          downsampled_img_1(i,j)=filtered_img(i*downsampling_rate,j*downsampling_rate);
      end
  end
    
  downsampled_img=downsampled_img_1;
    
%GAUSSIAN FILTER:
elseif strcmp(method,'Gaussian')  
    
    %Firstly, create the gaussian filter:
    %Parameters:
    height=17;
    width=17;
    mu=0;
    sigma=5;
    
    %Defines lengths of kernels X and Y based on inputs 'height' and 'width':
    sx=(height-1)/2;
    sy=(width-1)/2;

    %Implements such kernels X and Y using Matlab function 'meshgrid':
    [X,Y]=meshgrid(-sx:sx,-sy:sy);
    
    %Substitutes such kernels on gaussian filter formula:
    constant=2*pi*(sigma^2);

    filter=exp(-((X-mu).^2+(Y-mu).^2)./(2*(sigma^2)));
    filter=filter/constant;

    %And normalizes:
    sum1=sum(filter(:));
    filter=filter/sum1;

    %Convolve the input image with the previously created box filter:
    [R,C]=size(input_img);
    
    filtered_img=conv2(double(input_img),filter,'same');
    
    %Compute the downsampling:
    s1=floor(R/downsampling_rate);
    s2=floor(C/downsampling_rate);
    
    downsampling_size=[s1,s2];
    downsampled_img_1=uint8(zeros(downsampling_size));

    for i=1:downsampling_size(1)
        for j=1:downsampling_size(2)
            downsampled_img_1(i,j)=filtered_img(i*downsampling_rate,j*downsampling_rate);
        end
    end
    
    downsampled_img=downsampled_img_1;
    
end

end
