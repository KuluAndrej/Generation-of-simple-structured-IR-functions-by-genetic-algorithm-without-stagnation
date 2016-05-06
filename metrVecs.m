function [vecN, timeElapsed] = metrVecs(population, param)

THISFOLDER = fileparts(mfilename('fullpath'));
SELFFOLDER = fullfile(THISFOLDER,'self');
addpath(SELFFOLDER);

    
    numbl = length(population);
    distMat = zeros(numbl);
    lenspop = cellfun(@(x) length(x.Tokens), population);
    
    tic
    for ii =1:numbl
        for jj = 1:numbl
            if (param == 1)
                distMat(ii,jj) = metricMu1(population{ii}, population{jj});
            else 
                if (param == 2)
                    distMat(ii,jj) = metricMu2(population{ii}, population{jj});
                else
                    distMat(ii,jj) = metricMu3(population{ii}, population{jj});
                end
            end
        end
    end
    
    vecN = sum(sum(distMat))/mean(lenspop);
    timeElapsed = toc;
end