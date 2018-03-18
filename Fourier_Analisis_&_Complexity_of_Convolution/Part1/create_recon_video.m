function [] = create_recon_video(Recon)
% Your video should display top 100 fourier basis and their corresponding
% reconstructed images. After that display every 10th reconstructed image
% and its basis. Effectively you will get[num = 100+(M*N-100)/10] reconstructed 
% images in the image sequence to be converted to video.
% For creating the video - horizontally concatenate corresponding
% reconstructed images and fourier basis and follow the directions in 
% http://www.mathworks.com/help/matlab/examples/convert-between-image-sequences-and-video.html#zmw57dd0e6614
% Your function should save the video as 'Image_Recon.mov/avi'.

%Size of the reconstructed images:
[R,C]=size(Recon.image{1,1});

%Create the file:
outputVideo=VideoWriter('Image_Recon.avi');
outputVideo.FrameRate=1;
open(outputVideo)

final1=zeros(R,2*C);
final2=zeros(R,2*C);

%Write the sequence of images in the video file:
%Top 100 fourier basis and their corresponding reconstructed images:
for i=1:100     
   image=Recon.image{1,i};
   basis=Recon.basis{1,i};
   final1(:,1:C) = abs(image/255);
   final1(:,C+1:2*C) = basis;
   writeVideo(outputVideo,final1);
end

%Every 10th basis and its reconstructed image:
for i=100:10:R*C
   image=Recon.image{1,i};
   basis=Recon.basis{1,i};
   final2(:,1:C) = abs(image/255);
   final2(:,C+1:2*C) = basis;
   writeVideo(outputVideo,final2);
end
close(outputVideo)

fprintf('\nVideo created!\n');
end