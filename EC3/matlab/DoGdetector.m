function [locs, GaussianPyramid] = DoGdetector(I, sigma0, k, levels, theta_c,theta_r)

GaussianPyramid=createGaussianPyramid(I, sigma0, k, levels);
[DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);
PrincipalCurvature = computePrincipalCurvature(DoGPyramid);
locs=getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature,theta_c, theta_r);

figure(locs(1,2))
imshow(I);
hold on
scatter(locs(:,1,1),locs(:,2,1),'green','filled');
end
