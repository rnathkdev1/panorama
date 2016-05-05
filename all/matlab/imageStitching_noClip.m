function [panoImg] = imageStitching_noClip(im1, im2, H)

%% Calculating the edges of the transformed image
p1=[0 size(im2,2) size(im2,2) 0; 0 0 size(im2,1) size(im2,1); 1 1 1 1];
p2=H*p1;
p2(1,:)=p2(1,:)./p2(3,:);
p2(2,:)=p2(2,:)./p2(3,:);
p2(3,:)=[];

ypoints=p2(2,:);
xpoints=p2(1,:);

k=min(ypoints);
if k<0
    %Adding an offset of 5 to the exact translation
    k=abs(k)+5;
else k=0;
end
%% Adding suitable offsets and translations from above calculations
M=[1 0 5;0 1 k;0 0 1];

%% Calculating size of the template and adding an offset of 10
height=max(ypoints)-min(ypoints)+10;
width=max(xpoints)+10;
newsize=ceil([height, width]);

%% Defining masks
mask1 = zeros(size(im1,1), size(im1,2));
mask1(1,:) = 1; mask1(end,:) = 1; mask1(:,1) = 1; mask1(:,end) = 1;
mask1 = bwdist(mask1, 'city');
mask1 = mask1/max(mask1(:));

mask2 = zeros(size(im2,1), size(im2,2));
mask2(1,:) = 1; mask2(end,:) = 1; mask2(:,1) = 1; mask2(:,end) = 1;
mask2 = bwdist(mask2, 'city');
mask2 = mask2/max(mask2(:));

%% Warping all the images and masks
warp_im1=warpH(im1, M, newsize);
warp_im2=warpH(im2,M*H, newsize);
warp_mask1=warpH(mask1, M, newsize);
warp_mask2=warpH(mask2,M*H, newsize);

%% Weighted mean to get the new image
newim1(:,:,1)=(warp_im2(:,:,1).*warp_mask2+warp_im1(:,:,1).*warp_mask1)./(warp_mask2+warp_mask1);
newim1(:,:,2)=(warp_im2(:,:,2).*warp_mask2+warp_im1(:,:,2).*warp_mask1)./(warp_mask2+warp_mask1);
newim1(:,:,3)=(warp_im2(:,:,3).*warp_mask2+warp_im1(:,:,2).*warp_mask1)./(warp_mask2+warp_mask1);

panoImg=newim1;

end