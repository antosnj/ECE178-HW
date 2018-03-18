function outImg = myRichardsonLucy(Img,PSF,iter)

%Richardson Lucy algorithm:
[R,C]=size(PSF);
PSF_flip=zeros(R,C);

for i=1:R
    for j=1:C
        PSF_flip(i,j)=PSF(R+1-i,C+1-j);
    end
end

ut1=double(Img);
ut2=double(zeros(size(Img)));

%Iterative implementation:
for i=1:iter
    convolution1=conv2(ut1,PSF,'same');
    term=double(Img)./convolution1;
    convolution2=conv2(term,PSF_flip,'same');
    ut2=ut1.*convolution2;
    ut1=ut2;
end

%Assign 'ut2' to the function output to get the final result:
outImg=ut2;

end