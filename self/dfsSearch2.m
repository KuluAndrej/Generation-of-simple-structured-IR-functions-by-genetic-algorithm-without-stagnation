function [levels] = dfsSearch2(matr)
    point = 1;
    marked = -ones(1,length(matr));
    nextVerts = find(matr(point,:)==1);
    for ii = 1:nextVerts
        if (marked(nextVerts(ii))==-1)
            
        end
    end
end


function [result] = dfs(point, matr, marked)
    
    nextVerts = find(matr(point,:)==1);
    for ii = 1:length(nextVerts)
        if (marked(nextVerts(ii))==-1)
            level = dfs(nextVerts(ii), matr, marked)+1
        end
    end
    
end