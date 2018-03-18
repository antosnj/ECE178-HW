function scaled_img=linearStretching(input_img,start_intensity,end_intensity,stretching_x)

scaled_img=input_img;
[R,C]=size(input_img);
        
range=end_intensity-start_intensity; %Range of values whose value is not going to be 0 nor 255
    
for i=1:R
    for j=1:C
        if input_img(i,j)>=0 && input_img(i,j)<start_intensity
            scaled_img(i,j)=0;
        elseif input_img(i,j)>end_intensity && input_img(i,j)<=255
            scaled_img(i,j)=255;            
        elseif input_img(i,j)>=start_intensity && input_img(i,j)<=end_intensity
            %For these values, it normalizes and adjust the values to the
            %new ones given by the linear parameters.
            diff=double(input_img(i,j))-start_intensity;
            normalized=diff/range;
            scaled_img(i,j)=normalized*256;
        end
    end
end

end