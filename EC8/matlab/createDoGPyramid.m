function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)

[~,~,L]=size(GaussianPyramid);

DoGPyramid=[];

for i=2:L
    temp=GaussianPyramid(:,:,i)-GaussianPyramid(:,:,i-1);
    DoGPyramid=cat(3,DoGPyramid,temp);
end

DoGLevels=levels(2:end);
end