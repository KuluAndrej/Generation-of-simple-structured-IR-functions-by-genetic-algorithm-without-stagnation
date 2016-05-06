function [ populationNew ] = CrossoverPopulation( population, crossingAmount )
%CROSSOVERPOPULATION 
% Population crossover; population is a cell array of models
% Parameters for the crossover are chosen randomly; it should be fixed
%
% Inputs:
% population - 1-by-p cell array of models
% crossingAmount - number of models crossover iterations so that output
%  number of models equals crossingAmount * 2
%
% Outputs:
% populationNew - population after crossover
%
% Course: Machine Learning and Data Analysis
% Supervisor: V.V. Strijov
% Author: M. Kuznetsov
% Date 24.12.2013

% Initialize population
populationNew = cell(1, crossingAmount * 2);

for crossIdx = 1 : crossingAmount
    % Chose first model randomly
    firstModelIdx = randi(length(population));
    % Chose first submodel index randomly
    firstVertexIdx = randi(length(population{firstModelIdx}.Tokens));
    % Chose second model randomly
    secondModelIdx = randi(length(population));
    % Chose second submodel index randomly
    secondVertexIdx = randi(length(population{secondModelIdx}.Tokens));
    % Crossover first and second models according to their submodel indices
    [firstCoModel, secondCoModel] = CrossoverModels(population{firstModelIdx}, ...
        firstVertexIdx, population{secondModelIdx}, secondVertexIdx);
    populationNew{2 * crossIdx - 1} = firstCoModel;
    populationNew{2 * crossIdx} = secondCoModel;
end

end

