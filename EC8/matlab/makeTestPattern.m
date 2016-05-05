function [compareX, compareY] = makeTestPattern(patchWidth, nbits)

v=[1:patchWidth*patchWidth];
C=nchoosek(v,2);
n=size(C,1);
k=randperm(n,nbits);
A=C(k,:);
compareX=A(:,1);
compareY=A(:,2);
clearvars -except compareX compareY
save('testPattern.mat');
end

