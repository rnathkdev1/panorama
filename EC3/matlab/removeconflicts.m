function [matches,locs1,locs2]=removeconflicts(matches,locs1,locs2)

p1 = locs1(matches(:,1),1:2);
p2 = locs2(matches(:,2),1:2);

[~,ind]=unique(p2,'rows');
duplicate_ind = setdiff(1:size(p2, 1), ind);
duplicate_value = p2(duplicate_ind, :);

%% Removing conflicts from higher octaves (many to one mappings)
for i=1:size(duplicate_value,1)
    [~,indx]=ismember(p2,duplicate_value(i,:),'rows');
    indx=logical(indx);
    matches(indx,:)=[];
    p2(indx,:)=[];
end


end