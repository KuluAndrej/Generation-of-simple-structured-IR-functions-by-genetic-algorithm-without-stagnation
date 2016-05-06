function [ population ] = LearnPopulation( population, matDocRanks, matQueries, modelCharacteristics)
%LEARNPOPULATION
% Adjust parameters for each model in a population
%
% Inputs:
% population - cell array of models;
% y - m-by-1 target variable;
% X - m-by-n independent variable
% nlinopt - options for nlinfit (nonlinear regression adjustment) method
% pltopt - plotting options
%
% Outputs:
% population - cell array of model with adjusted parameters
%
% Course: Machine Learning and Data Analysis
% Supervisor: V.V. Strijov
% Author: M. Kuznetsov
% Date 24.12.2013

parfor (modelIdx = 1 : length(population),100)
    % Adjust parameters
    model = totalQuality(population{modelIdx}, matDocRanks, matQueries, modelCharacteristics);
    population{modelIdx} = model;
    % Plot result
    %PlotStruct(str2func(population{modelIdx}.Handle), population{modelIdx}.FoundParams, X, y, pltopt);
end;

end

