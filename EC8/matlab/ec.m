clc;
clear;
im1name='../results/ec8_1.jpg';
im2name='../results/ec8_2.jpg';
im3name='../results/ec8_3.jpg';

%% Processing Image1
im1=imread(im1name);
im1=im2double(im1);
im1=imresize(im1,0.25);
if size(im1,3)~=1
im1=rgb2gray(im1);
end
[locs1, desc1] = briefLite(im1);

%% Processing Image2
im2=imread(im2name);
im2=imresize(im2,0.25);
im2=im2double(im2);
im2=rgb2gray(im2);
[locs2, desc2] = briefLite(im2);

%% Processing image 3

im3=imread(im3name);
im3=imresize(im3,0.25);
im3=im2double(im3);
im3=rgb2gray(im3);
[locs3, desc3] = briefLite(im3);

%% Calulating matches between consecutive images

[matches12] = briefMatch(desc1, desc2);
[bestH12] = ransacH(matches12, locs1, locs2);
[matches23]=briefMatch(desc2, desc3);
[bestH23] = inv(ransacH(matches23, locs2, locs3));
%% Reading the images in RGB for display
im1=im2double(imread(im1name));
im1=imresize(im1,0.25);
im2=im2double(imread(im2name));
im2=imresize(im2,0.25);
im3=im2double(imread(im3name));
im3=imresize(im3,0.25);
%% Creating panorama
[panoImg]=imageStitching3(im1, im2, im3, bestH12, bestH23);
figure(999)
imshow(panoImg);
imwrite(panoImg,'../results/ec8_pan.jpg');