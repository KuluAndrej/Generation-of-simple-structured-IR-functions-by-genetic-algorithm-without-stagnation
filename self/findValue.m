function [result] = findValue(Matr, tokens,w,X)
    Root = 1;
    Matr = dlmread('tree2.txt');
    
    Matr = Matr - Matr';
    nsizeMat = length(Matr);
    incidMatr = arrayfun(@(x) {find(Matr(x,:)==1)}, 1:nsizeMat);
    
    fileName  = 'numbParam.txt';
    inputfile = fopen(fileName);
    matValues = textscan(inputfile, '%s%f', 'delimiter', ' ');
    vecDates    = matValues{1};
    vecInDeg   = matValues{2};  
    vecInDeg = vecInDeg';
    
    tokens = [{'times2_'} {'expl_'} {'x1'} {'x2'}];
    w = [1];
    X = [1 4];
    %form the encoding of functions
    
    vEncode = arrayfun(@(x) find(strcmp(tokens(x),vecDates)),1:length(tokens))
    vecActualDeg = vecInDeg(vEncode);
    vecActualDeg = [0 cumsum(vecActualDeg)];
    % intervals in w-vector for every leaf
    [CMatIsom, vecRepr, vLayers] = equivsets(Matr, vEncode);
    mx = max(vLayers);
    %process leaves
    indLeaves = find_leaves(Matr);
    vecsParEncode = arrayfun(@(x) {[vecActualDeg(x)+1:vecActualDeg(x+1)]},1:length(vecActualDeg)-1);    
    
    values = zeros(1,nsizeMat);
    values(indLeaves) = arrayfun(@(x) X(sscanf(tokens{indLeaves(x)},'%*c%f')), 1:length(indLeaves));
    for ii=mx-1:-1:1
        arrayTemp = vecRepr{ii};
        
        for jj=1:length(arrayTemp)
                tmp = arrayTemp{1}(jj);
                tmpFun = str2func(vecDates{vEncode(tmp)});
                
                values(incidMatr{jj})
                values(tmp) = tmpFun(w(vecsParEncode{tmp}),values(incidMatr{tmp}));
                values(CMatIsom{tmp}) = values(tmp);
        end
    end
    result = values(Root)
end
function [leaves] = find_leaves(m)
    leaves = sum(m,2);
    leaves = find(leaves<0);
    
end