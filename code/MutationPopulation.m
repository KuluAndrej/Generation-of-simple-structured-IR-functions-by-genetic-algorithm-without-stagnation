function [ populationNew ] = MutationPopulation( population, primitives, numVariables, mutationAmount)
%MUTATIONPOPULATION Summary of this function goes here
% Population mutation; population is a cell array of models
% Parameters for the mutation are chosen randomly; it should be fixed
%
% Inputs:
% population - 1-by-p cell array of models
% primitives - p-by-1 cell array of primitives, used for random submodels
%  construction
% numVariables - total number of variables
% mutationAmount - number of models to be mutated
%
% Outputs:
% populationNew - population after mutation
%
% Course: Machine Learning and Data Analysis
% Supervisor: V.V. Strijov
% Author: M. Kuznetsov
% Date 24.12.2013

% Initialize mutated population
populationNew = cell(1, mutationAmount);

for muIdx = 1 : mutationAmount
    % Choose model for mutation randomly
    model = population{randi(length(population))};
    % Choose submodel to be removed randomly
    vertexIdx = randi(length(model.Tokens));
    % Choose number of primitives in a randomly generated submodel
    numPrimitives = randi(3); % Fixme : Make it parameter
    % Mutate model
    populationNew{muIdx} = MutateModel(model, vertexIdx, primitives, numVariables, numPrimitives);
end

end

