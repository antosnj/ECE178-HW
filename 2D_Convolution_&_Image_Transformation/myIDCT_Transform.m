function rImg = myIDCT_Transform(dctImg)
% dctImg      : DCT transform of the input image (type: double)
% rImg        : recovered image after performing inverse DCT (type: double)

%% implement your inverse DCT transform here
[R,C]=size(dctImg);
matrix=double(zeros(R,C)); 

for i=0:R-1
    disp(i);
    for j=0:C-1
        aux=0;
        for k1=0:R-1
            for k2=0:C-1
                aux=aux+dctImg(k1+1,k2+1)*cos(pi/R*(i+0.5)*(k1+0.5))*cos(pi/C*(j+0.5)*(k2+0.5));
            end
        end
        matrix(i+1,j+1)=aux;
    end
end

constant=sqrt(4/(R*C));

rImg=constant*matrix;

end

