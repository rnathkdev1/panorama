clc;
clear;
im1=imread('../data/model_chickenbroth.jpg');
im1=im2double(im1);
if size(im1,3)~=1
    im1=rgb2gray(im1);
end
[locs1, desc1] = briefLite(im1);
im2=imread('../data/chickenbroth_01.jpg');
im2=im2double(im2);


if size(im2,3)~=1
    im2=rgb2gray(im2);
end

[locs2, desc2] = briefLite(im2);
[matches] = briefMatch(desc1, desc2);
plotMatches(im1, im2, matches, locs1, locs2);
