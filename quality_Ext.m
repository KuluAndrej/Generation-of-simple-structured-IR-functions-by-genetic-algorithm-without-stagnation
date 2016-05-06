function [qualValue] = quality_Ext(TopicId, matDocRel1,matDocRel2, matDocRanks, yy)

[~,d1] = sort(matDocRel1(2,:),'descend');
[~,d2] = sort(matDocRel2(2,:),'descend');

vec1 = matDocRel1(1,d1);
vec2 = matDocRel2(1,d2);

qualValue = permutatt(vec1, vec2);

