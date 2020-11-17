function outputImage = intensityLevelSlicing(image,min,max)
    outputImage = image;
    outputImage(image <= max & image >= min) = 180;
    imshow(outputImage);
end

