function im3 = generatePanorama(im1, im2)
%% Processing image 1 and 2
im1=im2double(im1);

if size(im1,3)~=1
im1g=rgb2gray(im1);
end

[locs1, desc1] = briefLite(im1g);

im2=im2double(im2);
im2g=rgb2gray(im2);

[locs2, desc2] = briefLite(im2g);
[matches] = briefMatch(desc1, desc2);

%% Calculating the homography without RANSAC
p1=[];
p2=[];

for i = 1:length(matches)
        p1 = cat(1,p1,locs1(matches(i,1),1:2));
        p2 = cat(1,p2,locs2(matches(i,2),1:2)); 
end
p1=p1';
p2=p2';
l=size(p1,2);
indices=randperm(l,4);
px=p1(:,indices);
py=p2(:,indices);
    
H=inv(computeH(px,py));
[panoImg] = imageStitching(im1, im2, H);
figure(101)
imshow(panoImg);
%% Without clipping and without RANSAC
[panoImg2] = imageStitching_noClip(im1, im2, H);
imwrite(panoImg,'../results/q6_2_pan.jpg');

%% Homography with RANSAC
[bestH] = ransacH(matches, locs1, locs2);
bestH=inv(bestH);
[panoImg3] = imageStitching_noClip(im1, im2, bestH);
figure(999)
imshow(panoImg3);
im3=panoImg3;
imwrite(panoImg3,'../results/q7_2_pan.jpg');
end