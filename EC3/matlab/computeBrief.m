function [newlocs,desc] = computeBrief(im, locs, levels, compareX, compareY,parameter)

%Taking each element in locs, we have
load(parameter,'sigma0');
k=sqrt(2);


%------------------------------------
m=size(locs,1);
newlocs=[];
[imrow, imcol]=size(im);
nbits=size(compareX,1);
rowindex=0;
for i=1:m
    row=locs(i,2);
    col=locs(i,1);
    pyramidlevel=locs(i,3);
    
    %TO check if this point is a valid point,
    if row-4<=0 || row+4>imrow || col-4<=0 || col+4>imcol
        %locs(i,:)=[];
        disp('Deleted one Loc');
        
        
        
    else
        rowindex=rowindex+1;
        newlocs=cat(1,newlocs,locs(i,:));
        %Calculating the gaussian at that particular level
        %YOU MAY HAVE TO DEFINE THE VALUES IF NOT IN WORKSPACE
        sigma_= sigma0*k^pyramidlevel;
        h = fspecial('gaussian',floor(3*sigma_*2)+1,sigma_);
        GaussianPyramid=imfilter(im,h);
        
        %Considering a 9x9 neighborhood
        
        area_interest=GaussianPyramid(row-4:row+4,col-4:col+4);
        for j=1:nbits
            p1=compareX(j);
            p2=compareY(j);
            
            [x1,y1]=ind2sub([9,9],p1);
            [x2,y2]=ind2sub([9,9],p2);
            
            if area_interest(x1,y1)<area_interest(x2,y2)
                desc(rowindex,j)=1;
            else desc(rowindex,j)=0;
            end
        end
        
    end
    
end
            
            

end