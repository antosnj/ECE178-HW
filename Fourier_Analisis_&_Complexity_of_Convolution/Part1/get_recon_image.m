function [R] = get_recon_image(M,N,F,B,p,q)
% This function weighs the basis with its corresponding fourier
% coefficient.
R=F(p+1,q+1)*B;
constant=(1/(M*N));
R=constant*R;

end