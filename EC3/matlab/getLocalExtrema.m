function locs = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature,th_contrast, th_r)

%Finding the points where the principal curvature is >theta_r for deletion.
logictheta_r=PrincipalCurvature>th_r;

%Removing the points where DoG is less than theta_contrast
logictheta_c=DoGPyramid<th_contrast;
%displayPyramid(DoGPyramid)
%[a,b,c]=find(PrincipalCurvature>th_r)
logicmax=imregionalmax(DoGPyramid);
%Removing the ones with curvature>th_r
logicmax(logictheta_r)=logical(0);
%Removing the ones with DoG<th_contrast
logicmax(logictheta_c)=logical(0);

[x y z]=ind2sub(size(logicmax),find(logicmax == 1));
locs=1;
col3=DoGLevels(z);
locs=cat(2,y,x,col3');

end

