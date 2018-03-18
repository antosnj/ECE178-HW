function img = myInvRadon(p, theta_all, filter)
% p: radon transform input (size: N x K) 
% theta_all: list of angles in degrees (length: K) 
% filter: string indicating the type of filter to be used
% img: reconstructed image (type: double)

%% Implement your function here
%Dimensions we need:
[N,K]=size(p);
dim=ceil(N/sqrt(2));
num_angles=length(theta_all);

%Defines elements we will use:
img=double(zeros(dim));
img_aux=double(zeros(N,K));
filtered=double(zeros(N,K));
filter_type=double(zeros(1,N));


%Depending on the string 'filter', builds each of the three different filters:
if strcmp(filter,'Ram-Lak')
    for i=0:N-1
        filter_type(1,i+1)=1/pi*abs(-pi+((2*pi*i)/(N-1)));
    end
    %Uses Matlab function 'ifftshift' to rescale the filter as we want:
    filter_type=ifftshift(filter_type);
    
elseif strcmp(filter,'Shepp-logan')
    for i=0:N-1
        filter_type(1,i+1)=1/pi*abs(-pi+((2*pi*i)/(N-1)))*sinc((-pi+((2*pi*i)/(N-1)))/(2*pi));
    end
    %Uses Matlab function 'ifftshift' to rescale the filter as we want:
    filter_type=ifftshift(filter_type);
    
elseif strcmp(filter,'Cosine')
    for i=0:N-1
        filter_type(1,i+1)=1/pi*abs(-pi+((2*pi*i)/(N-1)))*cos((-pi+((2*pi*i)/(N-1)))/2);
    end
    %Uses Matlab function 'ifftshift' to rescale the filter as we want:
    filter_type=ifftshift(filter_type);
end

%Computes filtering:
for j=1:K
    radon=p(:,j)';
    radon=fft(radon);
    radon=radon.*filter_type;
    filtered(:,j)=ifft(radon)';
end


for j=1:num_angles
    %Assigns every column of the previous filtered matrix to 'img_aux'
    for k1=1:N
        for k2=1:N
            img_aux(k1,k2)=filtered(k2,j);
        end
    end
    
    %Rotates, based on each angle:
    added=imrotate(img_aux,-theta_all(j));
    
    %Crops it and adds everything up:
    l1=size(added,2);
    l2=ceil((l1-size(img,2))/2);
    added=added(l2:dim+l2-1,l2:dim+l2-1);
    img=img+added;
end

%Output image is the following constant times previous result:
img=real(img*pi/(2*num_angles));