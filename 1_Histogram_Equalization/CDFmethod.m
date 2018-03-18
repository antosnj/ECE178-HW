function scaled_img = CDFmethod(input_img)

 scaled_img=input_img;
 [R,C]=size(input_img);
 num_pixels=R*C;
 
 histog=zeros(1,256); %Histogram vector (same code as 'plotMyHistogram' function for 256 bins).

for i=1:R
      for j=1:C
           if input_img(i,j)==0
              histog(1,input_img(i,j)+1)=histog(1,input_img(i,j)+1)+1;
           else 
              histog(1,input_img(i,j))=histog(1,input_img(i,j))+1;
           end
       end
end
 
 probabilities=histog/num_pixels; %Normalizes to get the probability of each value.
 cdf=zeros(1,256);
 cdf(1,1)=probabilities(1,1);
 
 %CDF vector construction:
 for k=1:255
     cdf(1,k+1)=cdf(1,k)+probabilities(1,k+1); 
 end
 
 %Output values: (L-1) times the CDF for each input pixel value
 for i=1:R
     for j=1:C
         if scaled_img(i,j)==0
           scaled_img(i,j)=(255)*cdf(1,1);             
         else
           scaled_img(i,j)=(255)*cdf(1,scaled_img(i,j));
         end
     end
 end
 
end