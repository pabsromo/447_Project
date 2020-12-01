%% Image prep
im1 = imread("447 Project Pictures\447_ImageSet-page-001.jpg");
im2 = imread("447 Project Pictures\447_ImageSet-page-002b.jpg");
im3 = imread("447 Project Pictures\447_ImageSet-page-003.jpg");
im4 = imread("447 Project Pictures\447_ImageSet-page-004.jpg");
im5 = imread("447 Project Pictures\447_ImageSet-page-005.jpg");
im6 = imread("447 Project Pictures\447_ImageSet-page-006.jpg");
im7 = imread("447 Project Pictures\447_ImageSet-page-007.jpg");
im8 = imread("447 Project Pictures\447_ImageSet-page-008.jpg");
im9 = imread("447 Project Pictures\447_ImageSet-page-009.jpg");
im10 = imread("447 Project Pictures\447_ImageSet-page-010.jpg");
im11 = imread("447 Project Pictures\447_ImageSet-page-011.jpg");

% Put images into an array to be iterated through
images = {im1,im2,im3,im4,im5,im6,im7,im8,im9,im10,im11};

% Create an empty array to store if the presence of coffee is detected on
% the image
hasCoffeeArray = zeros(11,1);

% Newline character for the output string
c = newline;

%% Processing the images
% Iterate through all the images in the array
for k = 1:2
    [hasCoffee, stainPercentage, mask] = coffeeFinder(cell2mat(images(k)), 181, 198, 162, 178, 141, 154);
    hasCoffeeArray(k) = hasCoffee;
    fprintf(['Image ' int2str(k) ' stain percentage: ' num2str(stainPercentage) c ])
    figure(); 
    subplot(1,2,1); imshow(cell2mat(images(k)));    
    subplot(1,2,2); imshow(mask); 
    sgtitle(int2str(k));
end

%% Coffee finder function
function [hasCoffee, stainPercentage, mask] = coffeeFinder(image, minR, maxR, minG, maxG, minB, maxB)
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

