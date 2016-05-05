function [locs, desc] = briefLite(im,parameterfile)

load('testPattern.mat');
load(parameterfile);

[locs, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, theta_c,theta_r);
[locs,desc] = computeBrief(im, locs, levels, compareX, compareY,parameterfile);

end