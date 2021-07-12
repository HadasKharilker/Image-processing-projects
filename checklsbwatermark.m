function  isfake=checklsbwatermark(watermark,image)
% checklsbwatermark function checks if an image has the watermark signature in
% its 3 lsb
% input:image and watermaek
% output: isfake=1 if the image has been manipulated
%         isfake=0 if the image is authentic and has the watermark signature


b1=bitget(image,1);
b2=bitget(image,2);
b3=bitget(image,3);


if isequal(b1,watermark)&&isequal(b2,watermark)&&isequal(b3,watermark)
    %the image is has not been manipulated
    isfake=0;
    
else
    isfake=1;
    
end


end

