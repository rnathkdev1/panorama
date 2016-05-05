function [locs,desc]=octave(im1)
 %Generating octave!
 
[locs1, desc1] = briefLite(im1,'parameters.mat');

mapx=[1:2:size(im1,2)];
mapy=[1:2:size(im1,1)];

%Resampling for a second octave
im2=im1(1:2:end,1:2:end);

[locs2, desc2] = briefLite(im2,'parameters.mat');

%Mapping the coordinates back to the larger image
locs2(:,1)=mapx(locs2(:,1));
locs2(:,2)=mapy(locs2(:,2));

% %removing the conflicting points form the locs1
% [~,indx]=ismember(locs1,locs2,'rows');
% indx=indx(indx~=0);
% 
% locs1(indx,:)=[];
% desc1(indx,:)=[];

locs=cat(1,locs1,locs2);
desc=cat(1,desc1,desc2);

end