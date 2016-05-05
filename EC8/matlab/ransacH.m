function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)

if nargin()==3
    nIter=100000;
    tol=10;
end


p1=[];
p2=[];

for i = 1:length(matches)
        p1 = cat(1,p1,locs1(matches(i,1),1:2));
        p2 = cat(1,p2,locs2(matches(i,2),1:2)); 
end
p1=p1';
p2=p2';

l=size(p1,2);
p1_homo=[p1;ones(1,l)];
maxinlier=0;

for i=i:nIter
    
    %Choose 4 random indices
    indices=randperm(l,4);
    px=p1(:,indices);
    py=p2(:,indices);
    
    H= computeH(px,py);
    
    p2_=H*p1_homo;
    p2_(1,:)=p2_(1,:)./p2_(3,:);
    p2_(2,:)=p2_(2,:)./p2_(3,:);
    p2_(3,:)=[];
    
    diff=p2_-p2;
    epsilon=round(sqrt(diff(1,:).^2 + diff(2,:).^2));
    
    numinlier=sum(epsilon<tol);
    
    if numinlier>=maxinlier
        maxinlier=numinlier;
        bestH=H;
        inlierindex=find(epsilon<tol);
    end
    
    
end
px_=p1(:,inlierindex);
py_=p2(:,inlierindex);
maxinlier
bestH= computeH(px_,py_);

end