clc;
clear;
%% Processing images
im1=imread('../data/chickenbroth_03.jpg');
im1=im2double(im1);


if size(im1,3)~=1
    im1=rgb2gray(im1);
end

im2=imresize(im1,0.5);
%% Octave function generates atleast 2 octaves for each image
[locs1, desc1] = octave(im1);

if size(im2,3)~=1
    im2=rgb2gray(im2);
end

[locs2, desc2] = octave(im2);
[matches] = briefMatch(desc1, desc2);

%% Removing many-to-one conflicting matches
[matches,locs1,locs2]=removeconflicts(matches,locs1,locs2);
plotMatches(im1, im2, matches, locs1, locs2);