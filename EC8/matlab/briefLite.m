function [locs, desc] = briefLite(im)

load('testPattern.mat');
load('parameters.mat');

[locs, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, theta_c,theta_r);
[locs,desc] = computeBrief(im, locs, levels, compareX, compareY);

end