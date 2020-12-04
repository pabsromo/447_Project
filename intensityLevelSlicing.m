function outputImage = intensityLevelSlicing(image, min, medSize, erodeSize, outputIntensity)
    
    outputImage = image;
    
    outputImage(image <= 255 & image >= min) = outputIntensity;
    outputImage = imerode(outputImage, ones(erodeSize,erodeSize));
    outputImage = medfilt2(outputImage, [medSize, medSize]);
end

