function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)

[x,y,L]=size(DoGPyramid);
H=[];
PrincipalCurvature=[];

for i=1:L
    [GrX, GrY]=gradient(DoGPyramid(:,:,i));
    
    [GrXX, GrXY]=gradient(GrX);
    [GrYX, GrYY]=gradient(GrY);
    
    for j=1:x
        for k=1:y
            H=[GrXX(j,k) GrXY(j,k); GrYX(j,k) GrYY(j,k)];
            PrincipalCurvature(j,k,i)=trace(H)^2/det(H);
        end
    end
    
    
end


end
