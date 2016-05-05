function [panoImg] = imageStitching3(imleft,immid, imright, Hleft, Hright)
%% Calculating the coordinates of the transformed left image
p1=[0 size(imleft,2) size(imleft,2) 0; 0 0 size(imleft,1) size(imleft,1); 1 1 1 1];
p2=Hleft*p1;
p2(1,:)=p2(1,:)./p2(3,:);
p2(2,:)=p2(2,:)./p2(3,:);
p2(3,:)=[];

yleft=p2(2,:);
xleft=p2(1,:);

pushYleft=min(yleft);
if pushYleft<0
    %Adding an offset of 5 to the exact translation
    pushYleft=abs(pushYleft)+5;
else pushYleft=0;
end

pushXleft=min(xleft);
if pushXleft<0
    %Adding an offset of 5 to the exact translation
    pushXleft=abs(pushXleft)+5;
else pushXleft=0;
end

%% Calculating the edges of the transformed right image
p1=[0 size(imright,2) size(imright,2) 0; 0 0 size(imright,1) size(imright,1); 1 1 1 1];
p2=Hright*p1;
p2(1,:)=p2(1,:)./p2(3,:);
p2(2,:)=p2(2,:)./p2(3,:);
p2(3,:)=[];

yright=p2(2,:);
xright=p2(1,:);

pushYright=min(yright);
if pushYright<0
    %Adding an offset of 5 to the exact translation
    pushYright=abs(pushYright)+5;
else pushYright=0;
end

%% Calculating the coordinates of the middle image
p1=[0 size(immid,2) size(immid,2) 0; 0 0 size(immid,1) size(immid,1); 1 1 1 1];
ymid=p1(2,:);
xmid=p1(1,:);


%% Plotting 
% figure(1)
% scatter (xleft,yleft);
% hold on;
% scatter(xmid,ymid);
% scatter(xright,yright);
% legend('left','mid','right');

%% Calculating the maximum pushY

pushY=max(pushYleft,pushYright);
M=[1 0 pushXleft;0 1 pushY;0 0 1];

%Calculating size of the template and adding an offset of 10
height=max([yright, yleft])-min([yright, yleft])+10;
width=max([xright, xleft])-min([xright, xleft])+10;

newsize=ceil([height, width]);

%% Defining masks and warps
maskleft = zeros(size(imleft,1), size(imleft,2));
maskleft(1,:) = 1; maskleft(end,:) = 1; maskleft(:,1) = 1; maskleft(:,end) = 1;
maskleft = bwdist(maskleft, 'city');
maskleft = maskleft/max(maskleft(:));

maskmid = zeros(size(immid,1), size(immid,2));
maskmid(1,:) = 1; maskmid(end,:) = 1; maskmid(:,1) = 1; maskmid(:,end) = 1;
maskmid = bwdist(maskmid, 'city');
maskmid = maskmid/max(maskmid(:));

maskright = zeros(size(imright,1), size(imright,2));
maskright(1,:) = 1; maskright(end,:) = 1; maskright(:,1) = 1; maskright(:,end) = 1;
maskright = bwdist(maskright, 'city');
maskright = maskright/max(maskright(:));

%Warping all the images and masks
warp_imleft=warpH(imleft, M*Hleft, newsize);
warp_immid=warpH(immid, M, newsize);
warp_imright=warpH(imright,M*Hright, newsize);

warp_maskleft=warpH(maskleft, M*Hleft, newsize);
warp_maskmid=warpH(maskmid, M, newsize);
warp_maskright=warpH(maskright,M*Hright, newsize);

% Weighted mean to get the new image
newim1(:,:,1)=(warp_imright(:,:,1).*warp_maskright+warp_immid(:,:,1).*warp_maskmid+warp_imleft(:,:,1).*warp_maskleft)./(warp_maskright+warp_maskmid+warp_maskleft);
newim1(:,:,2)=(warp_imright(:,:,2).*warp_maskright+warp_immid(:,:,2).*warp_maskmid+warp_imleft(:,:,2).*warp_maskleft)./(warp_maskright+warp_maskmid+warp_maskleft);
newim1(:,:,3)=(warp_imright(:,:,3).*warp_maskright+warp_immid(:,:,3).*warp_maskmid+warp_imleft(:,:,2).*warp_maskleft)./(warp_maskright+warp_maskmid+warp_maskleft);

panoImg=newim1;
imwrite(panoImg,'../results/q6_2_pan.jpg');

end