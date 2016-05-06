function [res, LR_key, encodeFMetr, lefts] = dfsSearch(matr)
    
    if size(matr)==1
        res = 1;
        LR_key = 1;
        encodeFMetr = 1;
        lefts = 1;
        
        return
    end
    m = matr;
    LR_key = zeros(1,length(m));
    lefts  = zeros(1,length(m));
    encodeFMetr = zeros(1,length(m));
    
    marked = -ones(1,length(m));
    indLeaves = find_leaves(m);
    for x = 1:length(indLeaves)
        lefts(indLeaves(x)) = indLeaves(x);
    end
    marked(indLeaves) = 0;

    LR_key(1) = 1;
    [~, marked, LR_key, encodeFMetr, lefts] = dfs(1, marked, m, LR_key, encodeFMetr, lefts);
    marked = max(marked)-marked+1;
    res = marked;
end

function [result, marked, LR_key, encodeFMetr, lefts] = dfs(x, marked, m, LR_key, encodeFMetr, lefts)


nextVer    = find(m(x,:) == 1);

mx = -1;
for i=1:length(nextVer)
    if i>1
        LR_key(nextVer(i)) = 1;
    end
    if (marked(nextVer(i))==-1)
        [mxtemp, marked, LR_key,encodeFMetr, lefts] = dfs(nextVer(i), marked, m, LR_key,encodeFMetr, lefts);
        mx = max(mxtemp, mx);
    else
        encodeFMetr(nextVer(i)) = max(encodeFMetr)+1;
        mxtemp = marked(nextVer(i));
        mx = max(mxtemp, mx);
    end
    
end

encodeFMetr(x) = max(encodeFMetr(nextVer))+1;
result = mx+1;
lefts(x) = lefts(nextVer(1));
marked(x) = result;

end

function [leaves] = find_leaves(m)
    leaves = sum(m,2);
    leaves = find(leaves<0);
    
end