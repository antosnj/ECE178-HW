function [B] = gen_fourier_basis(input_img,p,q)
% This function generates the (p,q)th basis for image I
[R,C]=size(input_img);

%Based on inverse 2D DFT formula (given that this basis will be used to
%reconstruct the image, we have:

for n=0:R-1
    for m=0:C-1
        B(n+1,m+1)=exp(1i*2*pi*((p*(n+1)/R)+(q*(m+1)/C)));
    end
end

end