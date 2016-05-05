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
im1=rgb2gray(im2);
end



nummatches=[];
x=0:10:180;

for i=x
    imtemp=imrotate(im2,i);
    [~, desc2] = briefLite(imtemp);
    
    [matches] = briefMatch(desc1, desc2);
    
    matchno=size(matches,1);
    nummatches=cat(1,nummatches,matchno);
    clear locs2 desc2 matches
end

bar(x,nummatches);