function [mmetrics] = metricMu2(modelA, modelB) 

    %matA = modelA.Mat;
    %matB = modelB.Mat;
    
    strCoding = 'QWERTYUIOPASDFGHJKLZXCVBNM123456789/*-+=?!';
    
    fileName  = 'numbParam.txt';
    inputfile = fopen(fileName);
    matValues = textscan(inputfile, '%s%f%f', 'delimiter', ' ');
    vecDates  = matValues{1};
    
    fclose('all'); 
    tokA = modelA.Tokens;
    tokB = modelB.Tokens;
    
    encodeA = arrayfun(@(x) find(strcmp(tokA{x},vecDates)),1:length(tokA));
    encodeB = arrayfun(@(x) find(strcmp(tokB{x},vecDates)),1:length(tokB));
    
    strModelA = strCoding(encodeA);
    strModelB = strCoding(encodeB);
    
    mmetrics = levens(strModelA,strModelB);
    
end