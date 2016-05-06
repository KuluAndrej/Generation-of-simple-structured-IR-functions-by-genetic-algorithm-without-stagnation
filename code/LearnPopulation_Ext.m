function [qualValue] = LearnPopulation_Ext( population, matDocRanks, matQueries, modelCharacteristics)
qualValue = zeros(length(population), length(population));
for modelIdx = 1 : length(population)
    for modelIdxJ = modelIdx+1 : length(population) 
        qualValue(modelIdx, modelIdxJ) = totalQuality_Ext(population{modelIdx}, population{modelIdxJ}, matDocRanks, matQueries, modelCharacteristics);
    end
end;
qualValue = qualValue + qualValue';
end

