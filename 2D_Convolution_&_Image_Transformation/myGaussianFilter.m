function filter = myGaussianFilter(height,width,mu,sigma)
% height   : height of the filter kernel matrix
% width    : width of the filter kernel matrix
% mu       : mean 
% sigma    : standard deviation
% filter   : output filter kernel matrix of type double

%% implement your Gaussian filter here
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

end
