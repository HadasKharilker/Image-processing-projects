function watermarkedImage=lsbwatermark(originalImage,hiddenImage)
% lsbwatermark hide the hiddenImage inside the 3 lsb of the originalImage
% lsbwatermark return the watermarkedImage, and also saves the image

%convert the originalImage to grayscale
originalImage= rgb2gray(originalImage);

%Get the number of rows and columns in the original image.
[Rows, Columns] = size(originalImage);

%convert the hidden image to Binary Image
hiddenImage = imbinarize(rgb2gray(hiddenImage));

% Resize the hidden image  and original image to same size
hiddenImage = imresize(hiddenImage,size(originalImage));
imwrite(hiddenImage,'watermark.bmp');

%show the originalImage and the converted hiddenImage
figure; montage({originalImage,hiddenImage})

%setting the 3 lsb to zero using bitshift operations
watermarkedImage = originalImage; % Initialize
for column = 1 : Columns
    for row = 1 : Rows
        watermarkedImage(row, column) = bitshift(watermarkedImage(row, column),-3);
        watermarkedImage(row, column) = bitshift(watermarkedImage(row, column),3);
    end
end

%amount of lsb we want to hide the image
bitToSet=3;

% Set the 3 lsb of the originalImage to the value of the watermark.
for bit=1 : bitToSet
    for column = 1 : Columns
        for row = 1 : Rows
            watermarkedImage(row, column) = bitset(watermarkedImage(row, column), bit, hiddenImage(row, column));
        end
    end
end
% Save the Image file
imwrite(watermarkedImage,'MsgIm.bmp');

end

