function [F] = my_dft_2D(input_img)
%% Calculate the Fourier coefficients for the input image
[R,C]=size(input_img);
F_1=zeros(R,C);
F=zeros(R,C);

%ALGORITHM: (This way to compute 2D DFT is way faster than computing the
%whole 2D DFT formula)

%First, fix each row of 'imput_img' and compute the 1D-DFT of the resulting 
%1D vector (all columns for each fixed row) and put the resulting vector in matrix F_1:
for n=0:R-1
    for k1=0:C-1
       for m=0:C-1
           F_1(n+1,k1+1)=F_1(n+1,k1+1)+double(input_img(n+1,m+1))*exp((-1i*2*pi*k1*m)/C);
       end
    end
end
 
%In an analogous way, now fix each column of previous result matrix F_1 and compute 
%the 1D-DFT of the resulting 1D vector (which now is all rows for each fixed column) and 
%put the resulting vector in matrix F, which is the final output of the function, that is,
%the expected 2D DFT:
for m=0:R-1
    for k2=0:R-1
       for n=0:R-1
           F(k2+1,m+1)=F(k2+1,m+1)+F_1(n+1,m+1)*exp((-1i*2*pi*k2*n)/R);
       end
    end
end
          
end