function  image_with_watermark= visible_watermark(image,watermark,intensity,position)
%visible_watermark function add a watermark on to an image, according to
%position and intensity scale and return the final result as image_with_watermark output
%INPUTS:1)image- the original image
%       2)watermark- the watermark image
%       3)intensity- double value between [0,1] that represnt the intensity
%       of the watemark as follows
%       -intensity=0 no watermark at all, only original image
%       -intensity=1 only watermark without the original image
%       -intensity= between 0 to 1 -week to strong respectively
%      	4)position - int value between 0-4 as follows:
%       -position=0 put the watermark in the center with original size of watermark
%       -position=1 put the watermark in the top left corner
%       -position=2 put the watermark in the top right corner
%       -position=3 put the watermark in the bottom left corner
%       -position=4 put the watermark in the bottom right corner
%      

%resize image to 256x256
image=imresize(image,[256 256]);

%convert image to gray level
image_gray=rgb2gray(image);
image_gray=im2uint8(image_gray);


%convert watermark to gray level
watermark=rgb2gray(watermark);

%creating image_with_watermark with zero values
image_with_watermark=zeros(256, 256, 'uint8');

    
%resize watermark according to poistion value
if position ==0 %center position
    temp=imresize(watermark,[256 256]);%resize watermark to 256x256
    image_with_watermark=temp;%applay resize watermark to image_with_watermark
else
    
    temp = imresize(watermark,[64,64],'bilinear');%resize watermark to 64x64
    [rows, cols] = size(temp);
    if position==1 %top left
        %Co-ordinnates to place the watermark
        X = 1;
        Y = 1;
        image_with_watermark(X:X+rows-1,Y:Y+cols-1,:) = temp;%applay resize watermark to image_with_watermark
    elseif position==2 %top right
        %Co-ordinnates to place the watermark
        X = 1;
        Y = 191;
        image_with_watermark(X:X+rows-1,Y:Y+cols-1,:) = temp;%applay resize watermark to image_with_watermark
    elseif position==3 %bottom left
        %Co-ordinnates to place the watermark
        X = 192;
        Y = 1;
        image_with_watermark(X:X+rows-1,Y:Y+cols-1,:) = temp;%applay resize watermark to image_with_watermark
    elseif position==4 %bottom right
        %Co-ordinnates to place the watermark
        X = 192;
        Y = 192;
        image_with_watermark(X:X+rows-1,Y:Y+cols-1,:) = temp;%applay resize watermark to image_with_watermark
        
    else
        error('position must be between 0-4 integer number')%position value not legal
    end
    
end



%if intensity1 return just the watermark
if intensity==1
    image_with_watermark=temp;
    
%else (between 0-0.99) 
elseif (intensity>=0) && (intensity<1)
    %calc watermark intensity
    image_with_watermark = immultiply(image_with_watermark,intensity);
    image_with_watermark=im2uint8(image_with_watermark);
    

    %applay the watermrk on image 
    for i=1: 256
        for j=1 : 256

            image_with_watermark(i,j)=image_gray(i,j)+image_with_watermark(i,j);
        end
    end
    
else
    error('intensity must be between 0-1 number')%position value not legal
end
end
