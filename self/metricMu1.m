function [metrValue] = metricIsom(modelA, modelB) 
    
    matA = modelA.Mat;
    matB = modelB.Mat;
    
    matA = matA - matA';
    matB = matB - matB';
    
    fileName  = 'numbParam.txt';
    inputfile = fopen(fileName);
    matValues = textscan(inputfile, '%s%f%f', 'delimiter', ' ');
    vecDates  = matValues{1};
    
    fclose('all'); 
    tokA = modelA.Tokens;
    tokB = modelB.Tokens;
    
    encodeA = arrayfun(@(x) find(strcmp(tokA{x},vecDates)),1:length(tokA));
    encodeB = arrayfun(@(x) find(strcmp(tokB{x},vecDates)),1:length(tokB));
    umat = unite_trees(matA, matB);
    
    rootEncode = max([encodeA, encodeB])+1;
    uencode = [rootEncode, encodeA, encodeB];
    
    [CMatIsom, ~, ~] = equivsets(umat,uencode);
    threshold = 1 + length(encodeA) + 0.5;
    
    outPut = cellfun(@(c) min(length(find(c>threshold)),length(find(c<threshold)))/max(1,length(c)),CMatIsom);
    
    %cellsDegrByLayersA = arrayfun(@(c) {degreesA(find(vLayers1==c))}, 1:max(vLayers1));
    %celldisp(cellsDegrByLayersA)
    indLeaves = find_leaves(umat);
    
    x1 = find(strcmp('x1',vecDates));
    x2 = find(strcmp('x2',vecDates));
    
    indsx1 = find(uencode==x1);
    indsx2 = find(uencode==x2);
    metrWithoutLvs = sum(outPut);
    metrWithoutLvs = metrWithoutLvs + min(length(find(indsx1>threshold)),length(find(indsx1<threshold)));
    metrWithoutLvs = metrWithoutLvs + min(length(find(indsx2>threshold)),length(find(indsx2<threshold)));
    
    metrValue = length(encodeA)+length(encodeB)-2*metrWithoutLvs;
end

function [unite_mat] = unite_trees(matr1, matr2)
    n1 = length(matr1);
    n2 = length(matr2);
    unite_mat = zeros(n1+n2+1);
    
    unite_mat(1,2) = 1; unite_mat(1,n1+2) = 1;
    unite_mat(2,1) = -1; unite_mat(n1+2,1) = -1;
    
    
    unite_mat(2:(1+n1),2:(1+n1)) = matr1;
    unite_mat((2+n1):(1+n1+n2),(2+n1):(1+n1+n2)) = matr2;
    
end

function [leaves] = find_leaves(m)
    leaves = sum(m,2);
    leaves = find(leaves<0);
    
end
