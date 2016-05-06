vec1 = [1,2,4]
vec2 = [0,3,5]

n1 = length(vec1);
uniteOne = [vec1, vec2];

[~, d1] = sort(uniteOne);
[~, d2] = sort(d1); % Find ind-s IX such that B(IX) = A, where B = sort(A)
vec1Slice = d2(1:n1);
finalVecToSolve = vec1Slice;
s = sum(finalVecToSolve) - n1*(n1+1)/2;
s