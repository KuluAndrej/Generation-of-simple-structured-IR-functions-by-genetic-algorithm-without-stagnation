function [metrWithoutLvs] = metricMu3(modelA, modelB) 


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
    
    
    [~, LR_key1, encodeFMetr1, lefts1] = dfsSearch(matA);
    [~, LR_key2, encodeFMetr2, lefts2] = dfsSearch(matB);
    
    
    LR_key1 = find(LR_key1);
    LR_key2 = find(LR_key2);
    
    lefts1 = encodeFMetr1(lefts1);
    lefts2 = encodeFMetr2(lefts2);
    
    [~,ix1] = sort(encodeFMetr1);
    [~,ix2] = sort(encodeFMetr2);
    
    encodeA = encodeA(ix1);
    encodeB = encodeB(ix2);
    
    
    LR_key1 = sort(encodeFMetr1(LR_key1));
    LR_key2 = sort(encodeFMetr2(LR_key2));
    
    lefts1 = lefts1(ix1);
    lefts2 = lefts2(ix2);
    
    treedist = zeros(length(matA),length(matB));
    for ii = 1:length(LR_key1)
    for jj = 1:length(LR_key2)
        i = LR_key1(ii);
        j = LR_key2(jj);

        li = lefts1(i);
        lj = lefts2(j);

        matDist = zeros(length(matA)+1,length(matB)+1);
        matDist(li:i+1,1) = 0:(i-lefts1(i)+1);
        matDist(1,lj:j+1) = 0:(j-lefts2(j)+1);


        for kk = li+1:i+1
            for ll = lj+1:j+1
                if (lefts1(kk-1)==li && lefts2(ll-1)==lj)
                    matDist(kk,ll) = ...
                        min([matDist(kk,ll-1)+1, matDist(kk-1,ll)+1, matDist(kk-1,ll-1)+(encodeA(kk-1)~=encodeB(ll-1))]);
                    treedist(kk-1,ll-1) = matDist(kk,ll);
                else
                   matDist(kk,ll) = ...
                      min([matDist(kk,ll-1)+1, matDist(kk-1,ll)+1, matDist(kk-1,ll-1)+ ...
                      (encodeA(kk-1)~=encodeB(ll-1))]);
                end
            end
        end

    end
    end
    metrWithoutLvs = treedist(length(matA),length(matB));
    

end