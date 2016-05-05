function [panoImg] = imageStitching(im1, im2, H)

%% Preparing masks 
mask2 = zeros(size(im2,1), size(im2,2));
mask2(:,1) = 1; mask2(end,:) = 1; mask2(:,1) = 1; mask2(:,end) = 1;
mask2 = bwdist(mask2, 'city');
mask2 = mask2/max(mask2(:));

mask1 = zeros(size(im1,1), size(im1,2));
mask1(:,1) = 1; mask1(:,end) = 1;
mask1 = bwdist(mask1, 'euclidean');
mask1 = mask1/max(mask1(:));


%% Preparing warps
warp_im2=warpH(im2, H, size(im1));
warp_mask2=warpH(mask2, H, size(im1));

figure(861)
imshow(warp_im2)
%% Stitching
newim1(:,:,1)=(warp_im2(:,:,1).*warp_mask2+im1(:,:,1).*mask1)./(warp_mask2+mask1);
newim1(:,:,2)=(warp_im2(:,:,2).*warp_mask2+im1(:,:,2).*mask1)./(warp_mask2+mask1);
newim1(:,:,3)=(warp_im2(:,:,3).*warp_mask2+im1(:,:,2).*mask1)./(warp_mask2+mask1);

panoImg=newim1;

imwrite(warp_im2,'../results/q6_1.jpg');
save('../results/q6_1.mat','H');

end
