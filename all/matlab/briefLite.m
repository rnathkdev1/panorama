function [locs, desc] = briefLite(im)

load('testPattern.mat');
load('parameters.mat');

[locs, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, theta_c,theta_r);
figure(locs(1,1))
displayPyramid(GaussianPyramid);
%[compareX, compareY] = makeTestPattern(patchWidth, nbits);
[locs,desc] = computeBrief(im, locs, levels, compareX, compareY);

end