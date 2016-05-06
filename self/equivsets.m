function [CMatIsom, vecRepr, vLayers] = equivsets(Matr, vEncode)
    
    %read data
    nsizeMat = length(Matr);
    
    % get layers
    [vLayers] = dfsSearch(Matr);
    mx = max(vLayers);
    
    indLeaves = find_leaves(Matr);
   
    vLeaves = vEncode(indLeaves);
    mnLeaves = min(vLeaves);
    vLeaves = vLeaves-mnLeaves+1;
    
    %[~, ~, indLeavesSorted] = unique(vLeaves);
    
    % vecNumOfCell - this structure will maintain number classes of
    % equivalency (array)
    vecNumOfCell = zeros(1,nsizeMat);
    vecNumOfCell(indLeaves) = vLeaves;
    % CMatIsom is cell-array containing equivalent vertices
    CMatIsom = cell(1,nsizeMat); 
    
    % incidMatr is incidency matrix
    incidMatr = arrayfun(@(x) {find(Matr(x,:)==1)}, 1:nsizeMat);
    
    %this vector will represent one entry of each class
    vecRepr = cell(1,mx-1);
    %we move for every layer and form classes of equivalency
    for i=mx-1:-1:1
        indNextLayer = find(vLayers==i);
        vecTrav = arrayfun(@(x) {vecNumOfCell(incidMatr{indNextLayer(x)})}, 1:length(indNextLayer));
        vecTrav = cellfun(@sort, vecTrav, 'UniformOutput', false);
        vecTrav = arrayfun(@(c) {[vEncode(indNextLayer(c)) vecTrav{c}]}, 1:length(vecTrav));
        
        [~,~,indAftSrtTrav] = unique(cellfun(@mat2str,vecTrav,'UniformOutput', false));
        %form new classes equiv.
        vecNumOfCell(indNextLayer) = indAftSrtTrav;
        data = sortrows([indAftSrtTrav'; indNextLayer].',1); 
        arrayPieces = accumarray(data(:,1),data(:,2)',[],@(x){x.'});
        vecRepr{i} = {sort(arrayfun(@(x) arrayPieces{x}(1), 1:length(arrayPieces)))};
        CMatIsom(indNextLayer) = arrayPieces(indAftSrtTrav).';
    end
    %here we assume that number of free variables is 2
    
end
function [leaves] = find_leaves(m)
    leaves = sum(m,2);
    leaves = find(leaves<0);
    
end