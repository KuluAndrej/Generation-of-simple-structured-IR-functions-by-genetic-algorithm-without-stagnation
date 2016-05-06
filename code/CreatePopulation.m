function [ population ] = CreatePopulation( models, initParams, primitives )
%CREATEPOPULATION
% Creates cell array of models
%
% Inputs:
% models - cell array of model strings
% initParams - cell array of initial parameters
% primitives - P-by-1 cell array of all primitives,
%
% Outputs:
% population - 1-by-p cell array of models
%
% Course: Machine Learning and Data Analysis
% Supervisor: V.V. Strijov
% Author: M. Kuznetsov
% Date 24.12.2013

nmodels = length(models);

if nargin<3, initParams = cell(size(models)); end
if nmodels ~= length(initParams)
    warning('Number of models does not equal to number of initial parameters; use default parameters instead');
    initParams = cell(size(models));  
end

population = cell(1,nmodels);
for i=1:nmodels
    population{1,i} = CreateModelByString(models{i}, primitives, initParams{i});
%    fprintf(1,'\nCreated: %s', population{1,i}.Name);
end

