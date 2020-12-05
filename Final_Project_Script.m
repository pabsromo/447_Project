% @Course:   ECEN 447-500
% @Authors:  Michael Collum, Pablo Romo
% @Date:     
% @Email:    mcollum29@tamu.edu, pabromo@tamu.edu

%% Setup

% Loading images
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

im1_gray = rgb2gray(imread("447 Project Pictures\447_ImageSet-page-001.jpg"));
im2_gray = rgb2gray(imread("447 Project Pictures\447_ImageSet-page-002.jpg"));
im3_gray = rgb2gray(imread("447 Project Pictures\447_ImageSet-page-003.jpg"));
im4_gray = rgb2gray(imread("447 Project Pictures\447_ImageSet-page-004.jpg"));
im5_gray = rgb2gray(imread("447 Project Pictures\447_ImageSet-page-005.jpg"));
im6_gray = rgb2gray(imread("447 Project Pictures\447_ImageSet-page-006.jpg"));
im7_gray = rgb2gray(imread("447 Project Pictures\447_ImageSet-page-007.jpg"));
im8_gray = rgb2gray(imread("447 Project Pictures\447_ImageSet-page-008.jpg"));
im9_gray = rgb2gray(imread("447 Project Pictures\447_ImageSet-page-009.jpg"));
im10_gray = rgb2gray(imread("447 Project Pictures\447_ImageSet-page-010.jpg"));
im11_gray = rgb2gray(imread("447 Project Pictures\447_ImageSet-page-011.jpg"));

%% Stain Detection

% If the output is 1 there is a stain, if 0 there is not a stain
staindetection(im1)
staindetection(im2)
staindetection(im3)
staindetection(im4)
staindetection(im5)
staindetection(im6)
staindetection(im7)
staindetection(im8)
staindetection(im9)
staindetection(im10)
staindetection(im11)

%% Full Implementation

% Assembling images in an array
originals = {im1 im2 im3 im4 im5 im6 im7 im8 im9 im10 im11};
grays = {im1_gray im2_gray im3_gray im4_gray im5_gray im6_gray im7_gray im8_gray im9_gray im10_gray im11_gray};
cleaned = {0 0 0 0 0 0 0 0 0 0 0};

for i = 1:11
    if staindetection(cell2mat(originals(i)))
        cleaned{i} = intensityLevelSlicing(cell2mat(grays(i)),mean(mean(cell2mat(grays(i)))) - 30,3,2,255);
    else
        cleaned{i} = cell2mat(grays(i));
    end
    figure();
    imshowpair(cell2mat(grays(i)),cell2mat(cleaned(i)),'montage');
end