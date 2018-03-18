function rImg = mySeamCarveResize(Img,rC,rR)
%rC: number of columns to be removed
%rR: number of row to be removed

[R,C,dim]=size(Img);

%Vertical resize, using previously implemented 'mySeamCarve_V.m' function:
vertical=Img;
for k=1:rC
    energy_matrix=myEnergyFunc(vertical(:,1:C-k,:));
    [E,S] = mySeamCarve_V(energy_matrix);
    for i=1:R
        for d=1:dim
            seam_index=S(i,1);
            vertical(i,seam_index:C-1,d)=vertical(i,seam_index+1:C,d);
            vertical(i,C+1-k,d)=0;
        end
    end
end

%Takes portion of matrix 'vertical' to get to final vertically resized
%image:
vertical=vertical(:,1:C-rC,:);

%Horizontal resize, using previously implemented 'mySeamCarve_H.m' function:
%( Now 'vertical' works as 'Img' in previous resize, as we are performing
%both vertical and horizontal resize over the initial image ):
C=size(vertical,2);
horizontal = vertical(:,1:C,:);
for k=1:rR
    energy_matrix=myEnergyFunc(horizontal(1:R-k,:,:));
    [E,S]=mySeamCarve_H(energy_matrix);
    for j=1:C
        for d=1:dim
            seam_index=S(1,j);
            horizontal(seam_index:R-1,j,d)=horizontal(seam_index+1:R,j,d);
            horizontal(R+1-k,j,d)=0;
        end
    end
end

%Finally, only takes the wanted portion of 'horizontal' ( that is, all rows but 
%the ones we just removed after finding all seams the image ) to get to the final result:
rImg = horizontal(1:R-rR,:,:);