function [cellArray] = cellFiller(population, cellArray, qualValue, param)
    
for modelIdx = 1 : length(population)
    for modelIdxJ = 1 : length(population) 
        if (param == 1)
            metrVal = metricMu1(population{modelIdx}, population{modelIdxJ});
        else
            if (param == 2)
                metrVal = metricMu2(population{modelIdx}, population{modelIdxJ});
            else
                metrVal = metricMu3(population{modelIdx}, population{modelIdxJ});
            end
        end
        metrVal = min(metrVal, 20);
        if (metrVal~=0) 
            cellArray(metrVal,2) = cellArray(metrVal,2) + 1;
            cellArray(metrVal,1) = cellArray(metrVal,1) + qualValue(modelIdx, modelIdxJ);
        end 
    end
end
    
end
