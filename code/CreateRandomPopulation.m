function [ population ] = CreateRandomPopulation( populationSize, primitives, numTotalVariables,  numPrimitives)
%CREATERANDOMPOPULATION
% Creates cell array of models chosing each model randomly
%
% Inputs:
% populationSize - size of population;
% primitives - P-by-1 cell array of all primitives;
% numTotalVariables - total number of variables;
% numPrimitives - desired number of primitive function for each model
%
% Outputs:
% population - 1-by-p cell array of models
%
% Course: Machine Learning and Data Analysis
% Supervisor: V.V. Strijov
% Author: M. Kuznetsov
% Date 24.12.2013
population = cell(0);
for ii = 1:length(populationSize)
    populationAdder = cell(1, populationSize(ii));
    for mdlIdx = 1 : populationSize(ii)
        % Create random model
        populationAdder{mdlIdx} = CreateRandomModel(primitives, numTotalVariables,  numPrimitives(ii));
    end;
    population = [population, populationAdder];
end



end

