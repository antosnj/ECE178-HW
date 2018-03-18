function dctImg = myDCT_Transform(input_image)
% input_image : input image (type: double)
% dctImg      : DCT transform of the input image (type: double)

%% implement your DCT transform here
[R,C]=size(input_image);
matrix=double(zeros(R,C));

for k1=0:R-1
    disp(k1);
    for k2=0:C-1
        aux=0;
        for i=0:R-1
            for j=0:C-1
                aux=aux+input_image(i+1,j+1)*cos(pi/R*(i+0.5)*(k1+0.5))*cos(pi/C*(j+0.5)*(k2+0.5));
            end
        end
        matrix(k1+1,k2+1)=aux;
    end
end

constant=sqrt(4/(R*C));
dctImg=constant*matrix;

end
