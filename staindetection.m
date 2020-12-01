function hasCoffee = staindetection(image)
% Takes in an image and determines if there is coffee based on a measured
% sample of RGB values

    % RGB threshold values for coffee stains
    minR = 181; maxR = 198; 
    minG = 162; maxG = 178;
    minB = 141; maxB = 154;
    
    % Get the size of the image being processed
    [X,Y,Z] = size(image);
    
    % Create a blank mask that will be used to show where coffee stains are
    % detected
    mask = zeros(X,Y);
    
    % Iterate through every pixel in the image to detect if there is a
    % coffee stain. The pixel must be within the range of the RGB values
    % that correlate with the brown of coffee on a page
    for i = 1:X
        for j = 1:Y
            if ((image(i,j,1) > minR) && (image(i,j,1) < maxR)... % R values
                && (image(i,j,2) > minG) && (image(i,j,2) < maxG)... % G values
                && (image(i,j,3) > minB) && (image(i,j,3) < maxB)) % B values
                mask(i,j) = 1; % Set the mask pixel value to 1 if coffee is detected
            end
        end
    end
    
    % Perform a large median filter to account for false positives
    mask = medfilt2(mask, [25,25]);
    
    % Count the number of presumed stained pixels in the image
    highVals = sum(mask(:) == 1);
    stainPercentage = (highVals / (X*Y))*100;
    
    % If the image is deemed to have greater than 0.1% coffee stain, it is
    % flagged as being stained. Otherwise, it is deemed clean.
    if stainPercentage > 0.1
        hasCoffee = 1;
    else
        hasCoffee = 0;
    end
end

