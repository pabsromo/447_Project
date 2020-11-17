function outputImage = intensityLevelSlicing(image, min, medSize, erodeSize, outputIntensity)
    outputImage = image;
    outputImage(image <= 255 & image >= min) = outputIntensity;
%     outputImage = imgaussfilt(outputImage, 5);
    outputImage = imerode(outputImage, ones(erodeSize,erodeSize));
    outputImage = medfilt2(outputImage, [medSize, medSize]);
    imshow(outputImage);
end

