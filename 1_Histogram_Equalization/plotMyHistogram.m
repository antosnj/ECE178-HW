function plotMyHistogram(input_img,num_bins)

[R,C]=size(input_img);

M=double(input_img)/256; %Normalizes input image values
T=M*num_bins; %Adjusts to new number of bins
T=ceil(T);  %Rounds that value up

histog=zeros(1,num_bins); %Histogram vector

for i=1:R
      for j=1:C
           if T(i,j)==0
              histog(1,T(i,j)+1)=histog(1,T(i,j)+1)+1;
           else 
              histog(1,T(i,j))=histog(1,T(i,j))+1;
           end
       end
end

end